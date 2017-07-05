import QtQuick 2.2
import QtQuick.Controls 1.2

Rectangle{
    //区域尺寸
    width:250;
    height:220;

    //拍摄图像按钮
    Button{
        //id
        id:imageOnShutBtn;

        //尺寸
        width:110;
        height: 110;

        //位置
        anchors.top : parent.top;
        anchors.topMargin: 30;
        anchors.left : parent.left;
        anchors.leftMargin: 10;
		
        text:"拍摄图像";

		//拍摄图像
		//向传感器发出命令，根据之前设置的触发条件，
		//进行图像拍摄，并实时在图像窗口更新
        onClicked: {

        }
    }

	//打开文件图像按钮
    Button{
        //id
        id:imageOnFileBtn;

        //尺寸
        width:110;
        height: 110;

        //位置
        anchors.top : parent.top;
        anchors.topMargin: 30;
        anchors.left : parent.left;
		anchors.leftMargin: 10*2+110;

        text:"打开文件";

		//打开文件对话框，选择之前保存的图像，更新显示在图像窗口
        onClicked: {
           
        }
    }


    /*应用按钮*/
    Button{
        //id
        id:confirmBtn;

        //尺寸
        width:90;
        height: 30;

        //位置
        anchors.bottom : parent.bottom;
        anchors.bottomMargin: 10;
        anchors.right : parent.right;
        anchors.rightMargin: 90+10*2;

        text:"确定";
		
		//确定使用当前图像区域中显示的图像，作为任务的模板图像，返回上一层（工具列表）
        onClicked: {
           
        }
    }

    /*取消按钮*/
    Button{
        //id
        id:cancleBtn;

        //尺寸
        width:90;
        height: 30;

        //位置
        anchors.bottom : parent.bottom;
        anchors.bottomMargin: 10;
        anchors.right : parent.right;
        anchors.rightMargin: 10;
		
        text:"取消";
		
		//不改变当前任务模板图像，返回上一层（工具列表）
        onClicked: {
           
        }
    }
}
