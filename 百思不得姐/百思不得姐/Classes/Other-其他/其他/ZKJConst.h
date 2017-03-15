
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
