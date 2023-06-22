module touchpad;

import org.eclipse.swt.SWT;
import org.eclipse.swt.events.MouseEvent;
import org.eclipse.swt.events.MouseMoveListener;
import org.eclipse.swt.events.MouseTrackAdapter;
import org.eclipse.swt.events.MouseTrackListener;
import org.eclipse.swt.events.PaintEvent;
import org.eclipse.swt.events.PaintListener;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.GC;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Display;

import std.format;

class TouchpadWidget {
    ubyte id1;
    ubyte id2;

    Color TOUCH_COLOR1;
    Color TOUCH_COLOR2;

    Canvas canvas;
    Shell shell;
    GC gc;

    this(Composite parentComp, Shell shell) {
        this.shell = shell;
        
        TOUCH_COLOR1 = shell.getDisplay().getSystemColor(SWT.COLOR_RED);
        TOUCH_COLOR2 = shell.getDisplay().getSystemColor(SWT.COLOR_CYAN);

        Composite composite = new Composite(parentComp, SWT.NONE);
        composite.setBounds(10, 10, 380, 380);

        canvas = new Canvas(composite, SWT.NONE);
        canvas.setBounds(0, 0, 380, 380);
        
        gc = new GC(canvas);

        enum maxX = 2000;
        enum maxY = 3300;
        enum TOUCH_SIZE = 30;

        canvas.addPaintListener(new class PaintListener {
            override void paintControl(PaintEvent event) {
                Point touchLocation1 = cast(Point)canvas.getData("touchLocation1");
                if (touchLocation1 !is null) {
                    int canvasWidth = canvas.getClientArea().width;
                    int canvasHeight = canvas.getClientArea().height;
                    int scaledX = touchLocation1.x * canvasWidth / maxX;
                    int scaledY = touchLocation1.y * canvasHeight / maxY;

                    gc.setBackground(TOUCH_COLOR1);
                    gc.fillOval(scaledX - TOUCH_SIZE / 2, scaledY - TOUCH_SIZE / 2, TOUCH_SIZE, TOUCH_SIZE);
                    gc.drawText(format!"%d"(id1), scaledX - TOUCH_SIZE / 4, scaledY - TOUCH_SIZE / 4);
                }

                Point touchLocation2 = cast(Point)canvas.getData("touchLocation2");
                if (touchLocation2 !is null) {
                    int canvasWidth = canvas.getClientArea().width;
                    int canvasHeight = canvas.getClientArea().height;
                    int scaledX = touchLocation2.x * canvasWidth / maxX;
                    int scaledY = touchLocation2.y * canvasHeight / maxY;
                    
                    gc.setBackground(TOUCH_COLOR2);
                    gc.fillOval(scaledX - TOUCH_SIZE / 2, scaledY - TOUCH_SIZE / 2, TOUCH_SIZE, TOUCH_SIZE);
                    gc.drawText(format!"%d"(id2), scaledX - TOUCH_SIZE / 4, scaledY - TOUCH_SIZE / 4);
                }
            }
        });
    }

    void setPoints(Point p1, ubyte id1, Point p2, ubyte id2){
        canvas.setData("touchLocation1", new Point(p1.x, p1.y));
        this.id1 = id1;
        canvas.setData("touchLocation2", new Point(p2.x, p2.y));
        this.id2 = id2;
        canvas.redraw();
        canvas.update;
    }

    ~this(){
        gc.dispose();
    }
}
