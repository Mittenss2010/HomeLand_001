import QtQuick 2.2
//import QtQuick.Controls 1.2
//import QtQuick.Controls.Styles 1.2

Rectangle {
    visible: true
    width: 500;
    height: 375;


    Image {
        id: backGround

        /*不透明度*/
        //opacity: 0.5
        z:1;

        anchors.fill: parent
        width: width;
        height: height;

        source: "forground.jpg"
    }

    Text{
        id:info00;
        x:20;
        y:20;
    }

    Text{
        id:info01;
        x:20;
        y:40;
    }

    Text{
        id:info02;
        x:20;
        y:60;
    }

    Text{
        id:info03;
        x:20;
        y:80;
    }
    Text{
        id:info04;
        x:20;
        y:100;
    }

    Text{
        id:info05;
        x:20;
        y:120;
    }

    Text{
        id:info06;
        x:20;
        y:140;
    }

    Text{
        id:info07;
        x:20;
        y:160;
    }


//*************************************************************************
    Canvas {
        id: mask;
        anchors.fill: parent;
        z: 1;

        property real w: 600;
        property real h: 600;
//        property real dx: 0;
//        property real dy: 0;
//        property real dw: 480;
//        property real dh: 320;

        /*鼠标实时位置*/
        property real frameX: 66;
        property real frameY: 66;

        /*old矩形位置，初始化为默认值*/
            /*矩形宽高*/
            property real oldRectWidth: 132;
            property real oldRectHeight: 132;

            /*矩形左上角位置*/
            property real oldRectX: 200;
            property real oldRectY: 200;

        /*cur矩形位置*/
            /*矩形宽高*/
            property real rectWidth: 132;
            property real rectHeight: 132;

            /*矩形左上角位置*/
            property real rectX : 200;
            property real rectY : 200;

        onPaint: {
            info00.text = '全局坐标（frameX,frameY）:'+ frameX + ',' + frameY;
            info01.text = '矩形坐标（oldRectX , oldRectY）：'+ oldRectX + ',' + oldRectY;
            info02.text = '矩形宽高（oldRectWidth , oldRectHeight）：'+ oldRectWidth + ',' + oldRectHeight;
            info03.text = '矩形角度（ratio）：'+ 'null';
            info04.text = '距矩形边缘距离（L，U，R，D）：'+ (frameX - oldRectX) + ','
                                                  + (frameY -oldRectY) + ','
                                                  + (frameX - oldRectX - oldRectWidth) + ','
                                                  + (frameY - oldRectY - oldRectHeight);
            var ctx = getContext("2d");



            /*清空区域，绘图，计算起点*/
            ctx.clearRect(0, 0, width, height);

            /*1.鼠标处于中心，只改变位置*/
            if((frameX > (oldRectX + 20))                       //大于左边+20
                && (frameY > (oldRectY + 20))                   //大于顶边+20
                && (frameX < (oldRectX + oldRectWidth - 20))    //小于右边-20
                && (frameY < (oldRectY + oldRectHeight - 20)))   //小于底边-20
            {
                /*矩形左上角位置*/
                rectX = frameX - oldRectWidth/2;
                rectY = frameY - oldRectHeight/2;
            }

            /*2.鼠标处于左边*/
            //根据old计算X坐标,D宽度，Y,H不发生变化
            if((frameX < (oldRectX + 20))                       //小于左边+20
                && (frameY > (oldRectY + 20))                   //大于顶边+20
                && (frameX > (oldRectX - 20))                   //大于左边-20
                && (frameY < (oldRectY + oldRectHeight - 20)))   //小于底边-20
            {
                /*矩形宽高位置*/
                rectWidth = oldRectX + oldRectWidth - frameX;
                //rectHeight = frameY;

                /*矩形左上角位置*/
                rectX = frameX;
                //rectY = frameY;
            }

            /*3.鼠标处于右边*/
            //根据old计算X坐标,D宽度，Y,H不发生变化
            if((frameX < (oldRectX + oldRectWidth + 20))        //小于右边+20
                && (frameY > (oldRectY + 20))                   //大于顶边+20
                && (frameX > (oldRectX + oldRectWidth - 20))    //大于右边-20
                && (frameY < (oldRectY + oldRectHeight - 20)))   //小于底边-20
            {
                /*矩形宽高位置*/
                rectWidth = frameX - oldRectX;
                //rectHeight = frameY;

                /*矩形左上角位置*/
                rectX = oldRectX;
                //rectY = frameY;
            }

            /*4.鼠标处于上边*/
            //根据old计算Y坐标,H高度，X，H不发生变化
            if((frameY < (oldRectY + 20))                       //小于顶边+20
                && (frameY > (oldRectY - 20))                   //大于顶边-20
                && (frameX < (oldRectX + oldRectWidth - 20))    //小于右边-20
                && (frameX > (oldRectX + 20)))                  //大于左边+20
            {
                /*矩形宽高位置*/
                //rectWidth = frameX - oldRectX;
                rectHeight = oldRectY + oldRectHeight - frameY;  //底边-顶边

                /*矩形左上角位置，不变*/
                //rectX = oldRectX;
                rectY = frameY;
            }

            /*5.鼠标处于下边*/
            //根据old计算Y坐标,H高度，X，H不发生变化
            if((frameY < (oldRectY + oldRectHeight + 20))        //小于底边+20
                && (frameY > (oldRectY + oldRectHeight - 20))    //大于底边-20
                && (frameX < (oldRectX + oldRectWidth - 20))    //小于右边-20
                && (frameX > (oldRectX + 20)))                  //大于左边+20
            {
                /*矩形宽高位置*/
                //rectWidth = frameX - oldRectX;
                rectHeight = frameY - oldRectY;                 //底边-顶边

                /*矩形左上角位置，不变*/
                //rectX = oldRectX;
                rectY = oldRectY;
            }

            /*6.鼠标处于左上角*/
            //右下边不发生变化，左上角变化
            if((frameX < (oldRectX + 20))                       //X坐标，小于左边+20
                && (frameX > (oldRectX - 20))                   //X坐标，大于左边-20
                && (frameY < (oldRectY + 20))                   //Y坐标，小于上边+20
                && (frameY > (oldRectY - 20)))                  //Y坐标，大于上边-20
            {
                /*矩形宽高位置*/
                rectWidth  = oldRectX - frameX + oldRectWidth;
                rectHeight = oldRectY - frameY + oldRectHeight;  //宽高偏移量 = 左上角 - 当前点

                /*矩形左上角位置，最新位置*/
                rectX = frameX;
                rectY = frameY;
            }

            /*7.鼠标处于右上角*/
            //【角度旋转】
            if((frameX < (oldRectX + oldRectWidth + 20))        //X坐标，小于右边+20
                && (frameX > (oldRectX + oldRectWidth - 20))    //X坐标，大于右边-20
                && (frameY < (oldRectY + 20))                   //Y坐标，小于上边+20
                && (frameY > (oldRectY - 20)))                  //Y坐标，大于上边-20
            {
    //            /*矩形宽高位置*/
    //            rectWidth  = frameX - oldRectX;
    //            rectHeight = oldRectY - frameY + oldRectHeight;  //新点，坐标加减

    //            /*矩形右上角位置，最新位置*/
    //            rectX = oldRectX;
    //            rectY = frameY;
            }

            /*8.鼠标处于左下角*/
            //左下角不发生变化，右上角变化
            if((frameX > (oldRectX - 20))                       //X坐标，大于左边 - 20
                && (frameX < (oldRectX + 20))                   //X坐标，小于左边 + 20
                && (frameY < (oldRectY + oldRectHeight + 20))   //Y坐标，小于下边 + 20
                && (frameY > (oldRectY + oldRectHeight - 20)))  //Y坐标，大于下边 - 20
            {
                /*矩形宽高位置*/
                rectWidth  = oldRectX -frameX + oldRectWidth;
                rectHeight = frameY -oldRectY;  //新点，坐标加减

                /*矩形右上角位置，最新位置*/
                rectX = frameX;
                rectY = oldRectY;
            }


            /*9.鼠标处于右下角*/
            //右下角不发生变化，↖角变化
            if((frameX > (oldRectX + oldRectWidth - 20))        //X坐标，大于右边 - 20
                && (frameX < (oldRectX + oldRectWidth + 20))    //X坐标，小于右边 + 20
                && (frameY < (oldRectY + oldRectHeight + 20))   //Y坐标，小于下边 + 20
                && (frameY > (oldRectY + oldRectHeight - 20)))  //Y坐标，大于下边 - 20
            {
                /*矩形宽高位置*/
                rectWidth  = frameX - oldRectX;
                rectHeight = frameY -oldRectY;                  //新点，坐标加减

                /*矩形右上角位置，最新位置*/
                rectX = oldRectY;
                rectY = oldRectY;
            }





            /*保存上下文，并进行绘制*/
            ctx.save( );
            ctx.strokeStyle = "red";         //边框色彩
            ctx.fillStyle = "#00000000";     //中空透明
            ctx.lineWidth = 2;               //边线长
            ctx.beginPath( );                /*开始绘制*/
            ctx.rect(rectX, rectY, rectWidth, rectHeight);
            ctx.fill( );
            ctx.stroke( );
            ctx.closePath( );                /*结束绘制*/

            ctx.clip();                      /*裁剪矩形*/
            ctx.drawImage("background.jpg", 0, 0, width, height)
            ctx.restore();

            /*【最后】更新old位置*/
            oldRectX = rectX;
            oldRectY = rectY;
            oldRectHeight = rectHeight;
            oldRectWidth = rectWidth;
            }

        Component.onCompleted: loadImage("background.jpg");
        onImageLoaded: requestPaint();





        /*目标区域，矩形位置*/
        Rectangle{
            id:targetRect;

            x:mask.oldRectX - 20;
            y:mask.oldRectY - 20;
            height: mask.oldRectHeight + 40;
            width : mask.oldRectWidth + 40;

            /*矩形区域旋转*/
            //rotation:45;

            /*不透明度*/
            opacity: 0;
            color:"gray";

            MouseArea{
                anchors.fill: parent

                /*鼠标点击事件传递*/
                onPressed: {

                    mouse.accepted = false;
                }

                /*悬浮操作使能*/
                hoverEnabled: true;
                onEntered: {
                    /*改变鼠标位置*/
                    console.log(" Target entered! ")

                }

                onPositionChanged: {

                    console.log("(x,y) = " + "(" + mouseX + "," + mouseY + ")");
                    console.log("(w,h) = " + "(" + mask.oldRectWidth + "," + mask.oldRectHeight + ")");
                    /*1.鼠标处于中心，十字型*/
                    if((mouseX > 40)                            //大于左边+40
                        && (mouseY > 40)                        //大于顶边+40
                        && (mouseX < mask.oldRectWidth )        //小于右边-40
                        && (mouseY < mask.oldRectHeight))       //小于底边-40
                    {
                        /*鼠标变为*/
                        cursorShape = Qt.SizeAllCursor;
                    }

                    /*2.鼠标处于左边*/
                    //根据old计算X坐标,D宽度，Y,H不发生变化
                    if((mouseX < 40)                       //小于左边+40
                        && (mouseY > 40)                   //大于顶边+40
                        && (mouseX > 0)                    //大于左边 0
                        && (mouseY < mask.oldRectHeight))  //小于底边 0
                    {
                        /*鼠标变为*/
                        cursorShape = Qt.SizeHorCursor;
                    }

                    /*3.鼠标处于右边*/
                    //根据old计算X坐标,D宽度，Y,H不发生变化
                    if((mouseX < mask.oldRectWidth + 40 )                //小于右边 0
                        && (mouseY > 40)                   //大于顶边+40
                        && (mouseX >  mask.oldRectWidth )    //大于右边-40
                        && (mouseY <  mask.oldRectHeight ))   //小于底边-40
                    {
                        /*鼠标变为*/
                        cursorShape = Qt.SizeHorCursor;
                    }

                    /*4.鼠标处于上边*/
                    //根据old计算Y坐标,H高度，X，H不发生变化
                    if((mouseX > 40)
                        && (mouseY > 0)
                        && (mouseX < mask.oldRectWidth)
                        && (mouseY < 40))
                    {
                        /*鼠标变为*/
                        cursorShape = Qt.SizeVerCursor;
                    }

                    /*5.鼠标处于下边*/
                    //根据old计算Y坐标,H高度，X，H不发生变化
                    if((mouseX > 40)
                        && (mouseY > mask.oldRectHeight)
                        && (mouseX < mask.oldRectWidth)
                        && (mouseY < mask.oldRectHeight + 40))
                    {
                        /*鼠标变为*/
                        cursorShape = Qt.SizeVerCursor;
                    }


                    /*7.鼠标处于右上角*/
                    //【角度旋转】
                    if((mouseX <     mask.oldRectWidth + 40)        //X坐标，小于右边+20
                        && (mouseX > mask.oldRectWidth)             //X坐标，大于右边-20
                        && (mouseY < 40)                            //Y坐标，小于上边+20
                        && (mouseY > 0))                           //Y坐标，大于上边-20
                    {
                        /* 矩形宽高位置 */
                        cursorShape = Qt.ClosedHandCursor
                    }
                }
            }
        }
    }

    /*获取变动的鼠标坐标信息*/
    MultiPointTouchArea {

        anchors.fill: parent;

        minimumTouchPoints: 1;
        maximumTouchPoints: 1;

        touchPoints:[
            TouchPoint{
                id: point1;
            }
        ]

        /*触点数据变化（按住，拖动），更新（数据，重绘）*/
        onUpdated: {

            /*先进行计算，根据条件重绘*/
            if((point1.x > 0) && (point1.y > 0) && (point1.x < width) && (point1.y < height))
            {
                mask.frameX = point1.x;
                mask.frameY = point1.y;
                mask.requestPaint();
            }
        }

        /*触点释放,当有触点（释放，删除）时，响应*/
        onReleased: {

        }

        /*触点按下，当有触点加入时，响应*/
        onPressed: {

        }
    }
}


//Qt::SizeVerCursor
//Qt::SizeHorCursor
//Qt::SizeBDiagCursor
//Qt::SizeFDiagCursor
//Qt::SizeAllCursor
