import 'package:flutter/material.dart';
import '../others/tools/constant.dart' show Constants, AppFontFamily, AppTextStyle;
import '../others/colors/colors.dart' show AppColor;
import '../model/conversationModel.dart' show ConversationModel, ConversationPageData;

class ConversationPageWidget extends StatelessWidget {
  final List<ConversationModel> conversations = ConversationPageData.conversationsList;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (BuildContext context, int index) {
          return ConversationItemWidget(
            conversationModel: conversations[index],
          );
        },
      ),
    );
  }
}

/*单个聊天item*/
class ConversationItemWidget extends StatelessWidget {
  ConversationItemWidget({Key key, ConversationModel conversationModel}):
  _conversationModel = conversationModel,
  super(key: key);
  final ConversationModel _conversationModel;
  @override
  Widget build(BuildContext context) {
    /*头像控件*/
    Widget _avatarWidget;
    if (this._conversationModel.isAvatarFromNet()) {
      _avatarWidget = Image.network(this._conversationModel.avatar,
        width: Constants.ConversationAvatarWidth,
        height: Constants.ConversationAvatarHeight,
      );
    } else {
      _avatarWidget = Image.asset(this._conversationModel.avatar,
        width: Constants.ConversationAvatarWidth,
        height: Constants.ConversationAvatarHeight,
      );
    }
    /*未读消息控件*/
    Widget _dotWidget = Container(
      width: Constants.ConversationDotSize,
      height: Constants.ConversationDotSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.ConversationDotSize / 2.0),
        color: AppColor.ConversationDotBgColor,
      ),
      alignment: Alignment.center,
      child: Text(this._conversationModel.unreadMsgCount.toString(),
        style: AppTextStyle.DotStyle,
      ),
    );

    /*头像和未读消息的组合控件*/
    Widget _avatarDotStackWidget;
    _avatarDotStackWidget = Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        _avatarWidget,
        Positioned(
          top: -3.0,
          right: -6.0,
          child: Container(
            child: this._conversationModel.unreadMsgCount != 0 ? _dotWidget : null,
          ),
        ),
      ],
    );

    /*右边的区域*/
    Widget _rightContainerWidget = Column(
      children: <Widget>[
        Text("12:00",
          style: AppTextStyle.SubtitleStyle,
        ),
        SizedBox(
          height: 6.0,
        ),
        Icon(
          IconData(
            0xe755,
            fontFamily: AppFontFamily.IconFontFamily,
          ),
          color: this._conversationModel.isMute ? AppColor.ConversationMuteIconColor : Colors.transparent,
          size: Constants.ConversationMuteIconSize,

        )
      ],
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColor.ConversationItemBgColor,
        border: Border(
          bottom: BorderSide(
            color: AppColor.ConversationSliverColor,
            width: 1.0
          )
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          children: <Widget>[
            _avatarDotStackWidget,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("手机号的护发素金凤凰技",
                      style: AppTextStyle.TitleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0)
                    ),
                    Text("收到货时间的不方便",
                      style: AppTextStyle.SubtitleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ),
            _rightContainerWidget,
          ],
        ),
      ),
    );
  }
}