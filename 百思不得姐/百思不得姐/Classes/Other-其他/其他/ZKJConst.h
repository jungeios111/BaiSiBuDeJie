
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZKJTopicTypeAll = 1,
    ZKJTopicTypePicture = 10,
    ZKJTopicTypeWord = 29,
    ZKJTopicTypeVoice = 31,
    ZKJTopicTypeVideo = 41,
} ZKJTopicType;

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const ZKJTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const ZKJTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const ZKJTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const ZKJTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const ZKJTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const ZKJTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const ZKJTopicCellPictureBreakH;

/** XMGUser模型-性别属性值 */
UIKIT_EXTERN NSString * const ZKJUserSexMale;
UIKIT_EXTERN NSString * const ZKJUserSexFemale;

/** 精华-cell-最热评论标题的高度 */
UIKIT_EXTERN CGFloat const ZKJTopicCellTopCmtTitleH;

/** tabBar被选中的通知名字 */
UIKIT_EXTERN NSString * const ZKJTabBarDidSelectNotification;
/** tabBar被选中的通知 - 被选中的控制器的index key */
UIKIT_EXTERN NSString * const ZKJSelectedControllerIndexKey;
/** tabBar被选中的通知 - 被选中的控制器 key */
UIKIT_EXTERN NSString * const ZKJSelectedControllerKey;
