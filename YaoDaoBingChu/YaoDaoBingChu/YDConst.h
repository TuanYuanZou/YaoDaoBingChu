#import <Foundation/Foundation.h>

#ifdef DEBUG
#define YDLog(...) NSLog(__VA_ARGS__)
#else
#define YDLog(...)
#endif

#define YDColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define YDGlobalBg YDColor(230, 230, 230)

#define YDNotificationCenter [NSNotificationCenter defaultCenter]

extern NSString *const YDPartnerNotification;
extern NSString *const YDSelectPartnerName;

extern NSString *const YDScanNotification;
extern NSString *const YDScanBarcode;