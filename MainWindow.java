package deneswt;

import org.eclipse.swt.SWT;
import org.eclipse.swt.events.KeyEvent;
import org.eclipse.swt.events.KeyListener;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.layout.*;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Combo;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.custom.StackLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Spinner;

public class MainWindow {

    private static Display display;
    private static Shell shell;
    private static Composite compositeRoot;
    private static Combo devsCombo;
    private static Label labelL2;
    private static Label L2force;
    private static Label labelR2;
    private static Label R2force;
    private static Label labelLX;
    private static Label labelLY;
    private static Label labelRX;
    private static Label labelRY;
    private static Label labelL1;
    private static Label labelL3;
    private static Label labelR1;
    private static Label labelR3;
    private static Label labelS;
    private static Label labelM;
    private static Label labelUp;
    private static Label labelLeft;
    private static Label labelRight;
    private static Label labelDown;
    private static Label labelPS;
    private static Label labelMic;
    private static Label labelTriangle;
    private static Label labelSquare;
    private static Label labelCircle;
    private static Label labelX;
    private static Composite compositeDispTouch;
    private static Label labelChargingStat;
    private static Label labelBatteryLevel;
    private static Label labelFullYesNo;
    private static Label label;
    private static Button buttonSetLedColor;
    private static Label labelFnLeft;
    private static Label labelFnRight;
    private static Label labelBottomLeft;
    private static Label labelBottomRight;
    private static Spinner spinnerLeftRumble;
    private static Spinner spinnerRightRumble;

    public static void main(String[] args) {
        display = new Display();
        shell = new Shell(display);
        shell.setMinimumSize(new Point(600, 500));
        shell.setSize(576, 420);
        shell.setText("PS5 Controller GUI");

        shell.pack();
        shell.setLayout(new RowLayout(SWT.HORIZONTAL));
        
        compositeRoot = new Composite(shell, SWT.NONE);
        compositeRoot.setLayout(new GridLayout(4, false));
        new Label(compositeRoot, SWT.NONE);
        
        Composite compositeDevice = new Composite(compositeRoot, SWT.NONE);
        RowLayout rl_compositeDevice = new RowLayout(SWT.HORIZONTAL);
        rl_compositeDevice.fill = true;
        compositeDevice.setLayout(rl_compositeDevice);
        
        Label lblDevicesFound = new Label(compositeDevice, SWT.NONE);
        lblDevicesFound.setText("Devices found:");
        
        devsCombo = new Combo(compositeDevice, SWT.READ_ONLY);
        devsCombo.setLayoutData(new RowData(144, -1));
        new Label(compositeRoot, SWT.NONE);
        new Label(compositeRoot, SWT.NONE);
        
        Composite compositeLeftStick = new Composite(compositeRoot, SWT.NONE);
        compositeLeftStick.setLayout(new FormLayout());
        
        Label _lblLeftStick = new Label(compositeLeftStick, SWT.NONE);
        _lblLeftStick.setText("Left stick");
        _lblLeftStick.setLayoutData(new FormData());
        
        Label _lblLX = new Label(compositeLeftStick, SWT.NONE);
        _lblLX.setText("x:");
        FormData fd__lblLX = new FormData();
        fd__lblLX.top = new FormAttachment(_lblLeftStick, 6);
        fd__lblLX.left = new FormAttachment(_lblLeftStick, 10, SWT.LEFT);
        _lblLX.setLayoutData(fd__lblLX);
        
        Label _lblLY = new Label(compositeLeftStick, SWT.NONE);
        _lblLY.setText("y:");
        FormData fd__lblLY = new FormData();
        fd__lblLY.top = new FormAttachment(_lblLX, 6);
        fd__lblLY.right = new FormAttachment(_lblLX, 0, SWT.RIGHT);
        _lblLY.setLayoutData(fd__lblLY);
        
        labelLX = new Label(compositeLeftStick, SWT.NONE);
        labelLX.setText("0");
        FormData fd_labelLX = new FormData();
        fd_labelLX.top = new FormAttachment(_lblLeftStick, 6);
        fd_labelLX.left = new FormAttachment(_lblLX, 6);
        labelLX.setLayoutData(fd_labelLX);
        
        labelLY = new Label(compositeLeftStick, SWT.NONE);
        fd_labelLX.right = new FormAttachment(labelLY, 0, SWT.RIGHT);
        labelLY.setText("0");
        FormData fd_labelLY = new FormData();
        fd_labelLY.top = new FormAttachment(labelLX, 6);
        fd_labelLY.right = new FormAttachment(_lblLY, 64, SWT.RIGHT);
        fd_labelLY.left = new FormAttachment(_lblLY, 6);
        labelLY.setLayoutData(fd_labelLY);
        
        Composite compositeButtons = new Composite(compositeRoot, SWT.NONE);
        compositeButtons.setLayout(null);
        
        labelL2 = new Label(compositeButtons, SWT.NONE);
        labelL2.setText("L2");
        labelL2.setBounds(35, 10, 15, 20);
        
        Label lblForce = new Label(compositeButtons, SWT.NONE);
        lblForce.setText("force:");
        lblForce.setBounds(35, 30, 37, 20);
        
        labelR2 = new Label(compositeButtons, SWT.NONE);
        labelR2.setText("R2");
        labelR2.setBounds(267, 10, 17, 20);
        
        labelL1 = new Label(compositeButtons, SWT.NONE);
        labelL1.setText("L1");
        labelL1.setBounds(10, 56, 15, 20);
        
        labelR1 = new Label(compositeButtons, SWT.NONE);
        labelR1.setText("R1");
        labelR1.setBounds(347, 56, 17, 20);
        
        labelL3 = new Label(compositeButtons, SWT.NONE);
        labelL3.setText("L3");
        labelL3.setBounds(10, 82, 15, 20);
        
        labelS = new Label(compositeButtons, SWT.NONE);
        labelS.setText("Create");
        labelS.setBounds(119, 82, 43, 20);
        
        labelM = new Label(compositeButtons, SWT.NONE);
        labelM.setText("Option");
        labelM.setBounds(188, 82, 46, 20);
        
        labelR3 = new Label(compositeButtons, SWT.NONE);
        labelR3.setText("R3");
        labelR3.setBounds(347, 82, 17, 20);
        
        labelUp = new Label(compositeButtons, SWT.NONE);
        labelUp.setText("↑");
        labelUp.setBounds(100, 105, 7, 20);
        
        labelTriangle = new Label(compositeButtons, SWT.NONE);
        labelTriangle.setText("△");
        labelTriangle.setBounds(256, 105, 13, 20);
        
        labelLeft = new Label(compositeButtons, SWT.NONE);
        labelLeft.setText("←");
        labelLeft.setBounds(80, 130, 13, 20);
        
        Label labelSpacer1 = new Label(compositeButtons, SWT.NONE);
        labelSpacer1.setText("   ");
        labelSpacer1.setBounds(152, 130, 12, 20);
        
        labelRight = new Label(compositeButtons, SWT.NONE);
        labelRight.setText("→");
        labelRight.setBounds(115, 130, 13, 20);
        
        labelSquare = new Label(compositeButtons, SWT.NONE);
        labelSquare.setText("□");
        labelSquare.setBounds(242, 130, 9, 20);
        
        labelCircle = new Label(compositeButtons, SWT.NONE);
        labelCircle.setText("○");
        labelCircle.setBounds(274, 130, 13, 20);
        
        labelDown = new Label(compositeButtons, SWT.NONE);
        labelDown.setText("↓");
        labelDown.setBounds(100, 155, 7, 20);
        
        labelPS = new Label(compositeButtons, SWT.NONE);
        labelPS.setText("PS");
        labelPS.setBounds(175, 130, 16, 20);
        
        labelX = new Label(compositeButtons, SWT.NONE);
        labelX.setText("x");
        labelX.setBounds(259, 155, 7, 20);
        
        Label lblForce_1 = new Label(compositeButtons, SWT.NONE);
        lblForce_1.setText("force:");
        lblForce_1.setBounds(267, 30, 37, 20);
        
        L2force = new Label(compositeButtons, SWT.NONE);
        L2force.setText("0");
        L2force.setBounds(78, 30, 60, 20);
        
        R2force = new Label(compositeButtons, SWT.NONE);
        R2force.setText("0");
        R2force.setBounds(310, 30, 60, 20);
        
        labelMic = new Label(compositeButtons, SWT.NONE);
        labelMic.setText("Mic");
        labelMic.setBounds(172, 155, 37, 20);
        
        spinnerLeftRumble = new Spinner(compositeButtons, SWT.BORDER);
        spinnerLeftRumble.setMaximum(255);
        spinnerLeftRumble.setBounds(0, 149, 59, 26);
        
        spinnerRightRumble = new Spinner(compositeButtons, SWT.BORDER);
        spinnerRightRumble.setMaximum(255);
        spinnerRightRumble.setBounds(311, 149, 59, 26);
        
        Label lblLrumble = new Label(compositeButtons, SWT.NONE);
        lblLrumble.setBounds(2, 130, 70, 20);
        lblLrumble.setText("LRumble");
        
        Label lblRrumble = new Label(compositeButtons, SWT.NONE);
        lblRrumble.setBounds(310, 130, 60, 20);
        lblRrumble.setText("RRumble");
        new Label(compositeRoot, SWT.NONE);
        
        Composite compositeRightStick = new Composite(compositeRoot, SWT.NONE);
        compositeRightStick.setLayout(new FormLayout());
        
        Label _lblRightStick = new Label(compositeRightStick, SWT.NONE);
        _lblRightStick.setText("Right stick");
        _lblRightStick.setLayoutData(new FormData());
        
        Label _lblRX = new Label(compositeRightStick, SWT.NONE);
        _lblRX.setText("x:");
        FormData fd__lblRX = new FormData();
        fd__lblRX.top = new FormAttachment(_lblRightStick, 6);
        fd__lblRX.left = new FormAttachment(_lblRightStick, 10, SWT.LEFT);
        _lblRX.setLayoutData(fd__lblRX);
        
        Label _lblRY = new Label(compositeRightStick, SWT.NONE);
        _lblRY.setText("y:");
        FormData fd__lblRY = new FormData();
        fd__lblRY.top = new FormAttachment(_lblRX, 6);
        fd__lblRY.right = new FormAttachment(_lblRX, 0, SWT.RIGHT);
        _lblRY.setLayoutData(fd__lblRY);
        
        labelRX = new Label(compositeRightStick, SWT.NONE);
        labelRX.setText("0");
        FormData fd_labelRX = new FormData();
        fd_labelRX.top = new FormAttachment(_lblRightStick, 6);
        fd_labelRX.left = new FormAttachment(_lblRX, 6);
        labelRX.setLayoutData(fd_labelRX);
        
        labelRY = new Label(compositeRightStick, SWT.NONE);
        fd_labelRX.right = new FormAttachment(labelRY, 0, SWT.RIGHT);
        labelRY.setText("0");
        FormData fd_labelRY = new FormData();
        fd_labelRY.top = new FormAttachment(labelRX, 6);
        fd_labelRY.right = new FormAttachment(_lblRY, 64, SWT.RIGHT);
        fd_labelRY.left = new FormAttachment(_lblRY, 6);
        labelRY.setLayoutData(fd_labelRY);
        
        Label lblEdgecontrols = new Label(compositeRoot, SWT.NONE);
        lblEdgecontrols.setText("Edge controls");
        
        Composite composite_edge = new Composite(compositeRoot, SWT.NONE);
        
        labelFnLeft = new Label(composite_edge, SWT.NONE);
        labelFnLeft.setBounds(10, 10, 70, 20);
        labelFnLeft.setText("Fn left");
        
        labelFnRight = new Label(composite_edge, SWT.NONE);
        labelFnRight.setBounds(310, 10, 60, 20);
        labelFnRight.setText("Fn right");
        
        labelBottomLeft = new Label(composite_edge, SWT.NONE);
        labelBottomLeft.setBounds(79, 10, 81, 20);
        labelBottomLeft.setText("Bottom left");
        
        labelBottomRight = new Label(composite_edge, SWT.NONE);
        labelBottomRight.setBounds(199, 10, 85, 20);
        labelBottomRight.setText("Bottom right");
        new Label(compositeRoot, SWT.NONE);
        new Label(compositeRoot, SWT.NONE);
        new Label(compositeRoot, SWT.NONE);
        
        Composite compositeTouch = new Composite(compositeRoot, SWT.NONE);
        compositeTouch.setLayout(null);
        
        Label lblTouchpad = new Label(compositeTouch, SWT.NONE);
        lblTouchpad.setText("Touchpad");
        lblTouchpad.setBounds(0, 0, 65, 20);
        
        compositeDispTouch = new Composite(compositeTouch, SWT.BORDER);
        compositeDispTouch.setBounds(0, 20, 374, 124);
        compositeDispTouch.setLayout(new RowLayout(SWT.HORIZONTAL));
        new Label(compositeRoot, SWT.NONE);
        new Label(compositeRoot, SWT.NONE);
        
        Composite compositeBattery = new Composite(shell, SWT.NONE);
        compositeBattery.setLayout(null);
        
        Label lblBattery = new Label(compositeBattery, SWT.NONE);
        lblBattery.setBounds(0, 0, 50, 20);
        lblBattery.setText("Battery:");
        
        Composite composite_1 = new Composite(compositeBattery, SWT.NONE);
        composite_1.setLocation(104, -3);
        composite_1.setSize(335, 23);
        composite_1.setLayout(null);
        
        labelChargingStat = new Label(composite_1, SWT.NONE);
        labelChargingStat.setText("not charging");
        labelChargingStat.setBounds(0, 3, 84, 20);
        
        Label lblLevel = new Label(composite_1, SWT.NONE);
        lblLevel.setText("Level:");
        lblLevel.setBounds(102, 3, 37, 20);
        
        labelBatteryLevel = new Label(composite_1, SWT.NONE);
        labelBatteryLevel.setText("0");
        labelBatteryLevel.setBounds(145, 3, 45, 20);
        
        Label lblFull = new Label(composite_1, SWT.NONE);
        lblFull.setText("Full:");
        lblFull.setBounds(216, 3, 37, 20);
        
        labelFullYesNo = new Label(composite_1, SWT.NONE);
        labelFullYesNo.setText("No");
        labelFullYesNo.setBounds(260, 3, 37, 20);
        
        label = new Label(shell, SWT.NONE);
        label.setText("                                           ");
        
        Composite compositeSetDevState = new Composite(shell, SWT.NONE);
        
        Label lblSetDeviceStates = new Label(compositeSetDevState, SWT.NONE);
        lblSetDeviceStates.setSize(113, 20);
        lblSetDeviceStates.setText("Set device states:");
        
        buttonSetLedColor = new Button(compositeSetDevState, SWT.NONE);
        buttonSetLedColor.setBounds(119, -5, 94, 30);
        buttonSetLedColor.setText("set led color");
        shell.open();

        addEventListeners();

        while (!shell.isDisposed()) {
            if (!display.readAndDispatch()) {
                display.sleep();
            }
        }

        display.dispose();
    }

    private static void addEventListeners() {
        shell.addKeyListener(new KeyListener() {
            public void keyPressed(KeyEvent e) {
                updateButtonColor(e.keyCode, true);
            }

            public void keyReleased(KeyEvent e) {
                updateButtonColor(e.keyCode, false);
            }
        });
    }

    private static void updateButtonColor(int keyCode, boolean pressed) {
        Color color = pressed ? display.getSystemColor(SWT.COLOR_GREEN) : display.getSystemColor(SWT.COLOR_WHITE);
    }
}
