//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_naver_map/FlutterNaverMapPlugin.h>)
#import <flutter_naver_map/FlutterNaverMapPlugin.h>
#else
@import flutter_naver_map;
#endif

#if __has_include(<geolocator_apple/GeolocatorPlugin.h>)
#import <geolocator_apple/GeolocatorPlugin.h>
#else
@import geolocator_apple;
#endif

#if __has_include(<kakao_flutter_sdk_common/KakaoFlutterSdkPlugin.h>)
#import <kakao_flutter_sdk_common/KakaoFlutterSdkPlugin.h>
#else
@import kakao_flutter_sdk_common;
#endif

#if __has_include(<path_provider_foundation/PathProviderPlugin.h>)
#import <path_provider_foundation/PathProviderPlugin.h>
#else
@import path_provider_foundation;
#endif

#if __has_include(<shared_preferences_foundation/SharedPreferencesPlugin.h>)
#import <shared_preferences_foundation/SharedPreferencesPlugin.h>
#else
@import shared_preferences_foundation;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterNaverMapPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterNaverMapPlugin"]];
  [GeolocatorPlugin registerWithRegistrar:[registry registrarForPlugin:@"GeolocatorPlugin"]];
  [KakaoFlutterSdkPlugin registerWithRegistrar:[registry registrarForPlugin:@"KakaoFlutterSdkPlugin"]];
  [PathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"PathProviderPlugin"]];
  [SharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"SharedPreferencesPlugin"]];
}

@end
