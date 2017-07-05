import QtQuick 2.2
import QtQuick.Controls 1.2



Rectangle{
    //区域尺寸
    width:640;
    height:480;

    //变量，记录按钮当前状态(0-3，表示四种工具)
    property int btnState: 0;

    //轮廓按钮
    Button{
        //id
        id:contourBtn;

        //尺寸
        width:140;
        height: 80;

        //位置
        anchors.top : parent.top;
        anchors.topMargin: 30;
        anchors.left : parent.left;

        text:"Contour";

        onClicked: {
            btnState = 0;
            toolsDetileCanvas.requestPaint();
        }
    }

    Button{
        //id
        id:colorAreaBtn;

        //尺寸
        width:140;
        height: 80;

        //位置
        anchors.top : contourBtn.bottom;
        anchors.topMargin: 30;
        anchors.left : parent.left;

        text:"ColorArea";

        onClicked: {
            btnState = 1;
            toolsDetileCanvas.requestPaint();
        }
    }

    Button{
        //id
        id:widthBtn;

        //尺寸
        width:140;
        height: 80;

        //位置
        anchors.top : colorAreaBtn.bottom;
        anchors.topMargin: 30;
        anchors.left : parent.left;

        text:"Width";

        onClicked: {
            btnState = 2;
            toolsDetileCanvas.requestPaint();
        }
    }

    Button{
        //id
        id:diameterBtn;

        //尺寸
        width:140;
        height: 80;

        //位置
        anchors.top : widthBtn.bottom;
        anchors.topMargin: 30;
        anchors.left : parent.left;

        text:"Diameter";

        onClicked: {
            btnState = 3;
            toolsDetileCanvas.requestPaint();
        }
    }

    /*应用按钮*/
    Button{
        //id
        id:confirmBtn;

        //尺寸
        width:100;
        height: 35;

        //位置
        anchors.bottom : parent.bottom;
        anchors.bottomMargin: 2.5;
        anchors.left : parent.left;
        anchors.leftMargin: 370;

        text:"应用";
    }

    /*取消按钮*/
    Button{
        //id
        id:cancleBtn;

        //尺寸
        width:100;
        height: 35;

        //位置
        anchors.bottom : parent.bottom;
        anchors.bottomMargin: 2.5;
        anchors.left : confirmBtn.right;
        anchors.leftMargin: 35;
        text:"取消";
    }

    Rectangle{

        //id
        id: toolsDetileRect;

        //尺寸
        width:440;
        height: 410;

        //位置
        anchors.top : parent.top;
        anchors.topMargin: 30;
        anchors.left : parent.left;
        anchors.leftMargin: 170;

        //color
        color:"lightgray";

        //圆角
        radius: 5;

        //绘图
        Canvas {

            //id
            id:toolsDetileCanvas

            //尺寸
            width:420;
            height: 390;

            //位置
            anchors.top : parent.top;
            anchors.topMargin: 10;
            anchors.left : parent.left;
            anchors.leftMargin: 10;


            //绘制默认背景
           function drewDefaultBackground(draw , color)
           {
               //暂时使用ctx状态
               draw.save();
               draw.fillStyle = color
               draw.rect(0, 0, toolsDetileCanvas.width, toolsDetileCanvas.height);
               draw.fill();
               draw.stroke();
               draw.restore();

           }

           //绘制轮廓信息
            function paintContour(draw)
            {
                //绘制文本
                draw.beginPath();
                draw.fillText(" 轮廓工具：基于模板图像的轮廓信息，", 0, 210);
                draw.fillText(" 检测对象的相似度", 0, 240);
                draw.fillText(" 添加轮廓工具到当前任务", 180, 50);

                //绘制图标
                draw.drawImage(iCO1, 10, 10, 160, 160);
            }

            //绘制色彩面积信息
            function paintColorArea(draw)
            {

                //绘制文本
                draw.beginPath();
                draw.fillText(" 色彩面积工具：基于优良品模板图像的像素数，", 0, 210);
                draw.fillText(" 检测对象的相似度", 0, 240);
                draw.fillText(" 添加色彩面积工具到当前任务", 180, 50);

                //绘制图标
                draw.drawImage(iCO2, 10, 10, 160, 160);
            }

            //绘制宽度信息
            function paintWidth(draw)
            {

                //绘制文本
                draw.beginPath();
                draw.fillText(" 宽度工具：基于模板图像的边缘间宽度，", 0, 210);
                draw.fillText(" 检测对象的相似度", 0, 240);
                draw.fillText(" 添加宽度工具到当前任务", 180, 50);

                //绘制图标
                draw.drawImage(iCO3, 10, 10, 160, 160);
            }

            //绘制直径信息
            function paintDiameter(draw)
            {

                //绘制文本
                draw.beginPath();
                draw.fillText(" 直径工具：基于模板图像的直径为基准，", 0, 210);
                draw.fillText(" 检测对象的相似度", 0, 240);
                draw.fillText(" 添加直径工具到当前任务", 180, 50);

                //绘制图标
                draw.drawImage(iCO4, 10, 10, 160, 160);
            }
            Image {
                id: iCO1;
                source: "ICO1.jpg";
                visible: false;
            }

            Image {
                id: iCO2;
                source: "ICO2.jpg";
                visible: false;
            }

            Image {
                id: iCO3;
                source: "ICO3.jpg";
                visible: false;
            }

            Image {
                id: iCO4;
                source: "ICO4.jpg";
                visible: false;
            }

            //绘制
            onPaint: {

                var ctx = getContext("2d");

                /*  设置字体  */
                ctx.lineWidth = 2;
                ctx.strokeStyle = "red";
                //字体
                ctx.font = "20px sans-serif";
                //draw.font = "italic bold 32px serif"
                //draw.font = "italic 80 32px serif"
                //draw.font = "normal small-caps normal 32px monospace"

                //色彩梯度
                var gradient = ctx.createLinearGradient(0, 0, width, height);
                gradient.addColorStop(0.0, Qt.rgba(0, 1, 0, 1));
                gradient.addColorStop(1.0, Qt.rgba(0, 0, 1, 1));
                ctx.fillStyle = gradient;


                //首先默认背景
                drewDefaultBackground(ctx, "#ffffff");     //浅红色，增加亮度


                //根据当前Btn状态选择绘制
                switch(btnState){
                case 0:
                    paintContour(ctx);
                    break;
                case 1:
                    paintColorArea(ctx);
                    break;
                case 2:
                    paintWidth(ctx);
                    break;
                case 3:
                    paintDiameter(ctx);
                    break;
                }
            }
        }
    }
}
