//
//  ZBJSystemInfo.m
//  ZBJPoplar
//
//  Created by zoubenjun on 2020/12/30.
//

#import "ZBJSystemInfo.h"
#import <sys/sysctl.h>
#import <mach-o/arch.h>
#import <sys/utsname.h>
#import <AdSupport/ASIdentifierManager.h>

@interface ZBJSystemInfo ()

@property (atomic, assign, readwrite) BOOL isForeground;

@end

@implementation ZBJSystemInfo

kSingleton_M(SystemInfo);

- (instancetype)init {
    if (self = [super init]) {
        NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
        _bundleID = infoDict[@"CFBundleIdentifier"];
        _bundleName = infoDict[@"CFBundleName"];
        _bundleDisplayName = infoDict[@"CFBundleDisplayName"];
        _bundleVersion = infoDict[@"CFBundleVersion"];
        _bundleShortVersion = infoDict[@"CFBundleShortVersionString"];
        _uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        _idfa = getIdfa();
        _deviceLanguage = getDeviceLanguage();
        _platform = getPlatform();
        _systemVersion = [[UIDevice currentDevice] systemVersion];
        _cpuType = getCPUType();
        _osVersion = [NSString stringWithFormat:@"iOS %@(%@)",getOSVersion(), osBuildVersion()];
        _processID = getpid();
        _processName = [NSProcessInfo processInfo].processName;
        _parentProcessID = getppid();
        _parentProcessName = getParrentProcessName();
        _isForeground = YES;
        @weakself;
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongself;
            self.isForeground = [UIApplication sharedApplication].applicationState != UIApplicationStateBackground;
        });
        [self registerApplicationNotification];
        
    }
    return self;
}

- (void)registerApplicationNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationEnterForeground)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationEnterBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationEnterForeground {
    self.isForeground = YES;
}

- (void)applicationEnterBackground {
    self.isForeground = NO;
}

static NSString *getIdfa() {
    if ([[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
        return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

static NSString *getDeviceLanguage() {
    NSArray *languageArray = [NSLocale preferredLanguages];
    return [languageArray objectAtIndex:0];
    
}

static NSString *getPlatform() {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

static NSString *getCPUType() {
    const NXArchInfo* archInfo = NXGetLocalArchInfo();
    NSString *CPUArch = archInfo ? [NSString stringWithUTF8String:archInfo->name] : nil;
    
    if ([CPUArch rangeOfString:@"arm64"].location == 0) {
        return @"ARM-64";
    }
    if ([CPUArch rangeOfString:@"arm"].location == 0) {
        return @"ARM";
    }
    if ([CPUArch isEqualToString:@"x86"]) {
        return @"X86";
    }
    if ([CPUArch isEqualToString:@"x86_64"]) {
        return @"X86_64";
    }
    return @"Unknown";
}

static NSString *getOSVersion() {
    NSOperatingSystemVersion version = {0, 0, 0};
    if (@available(macOS 10.10, *)) {
        version = [NSProcessInfo processInfo].operatingSystemVersion;
    }
    NSString* systemVersion;
    if (version.patchVersion == 0) {
        systemVersion = [NSString stringWithFormat:@"%d.%d", (int)version.majorVersion, (int)version.minorVersion];
    } else {
        systemVersion = [NSString stringWithFormat:@"%d.%d.%d", (int)version.majorVersion, (int)version.minorVersion, (int)version.patchVersion];
    }
    return systemVersion;
}

static NSString *osBuildVersion() {
    int mib[2] = {CTL_KERN, KERN_OSVERSION};
    u_int namelen = sizeof(mib) / sizeof(mib[0]);
    size_t bufferSize = 0;

    NSString *osBuildVersion = nil;

    // Get the size for the buffer
    sysctl(mib, namelen, NULL, &bufferSize, NULL, 0);

    char buildBuffer[bufferSize];
    int result = sysctl(mib, namelen, buildBuffer, &bufferSize, NULL, 0);

    if (result >= 0) {
        osBuildVersion = [[NSString alloc] initWithUTF8String:buildBuffer];
    }

    return osBuildVersion;
}

static NSString *getParrentProcessName() {
    pid_t ppid = getppid();
    if (ppid == 1) {
        return @"launchd";
    }
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_PID, ppid};
    struct kinfo_proc info = {0};
    size_t size = sizeof(info);
    if (sysctl(mib, sizeof(mib) / sizeof(*mib), &info, &size, NULL, 0)) {
        return @"?";
    }
    return [NSString stringWithFormat:@"%s", info.kp_proc.p_comm];
}

@end
