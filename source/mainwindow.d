module mainwindow;

import std.format;
import std.conv;

import org.eclipse.swt.SWT;
import org.eclipse.swt.events.KeyEvent;
import org.eclipse.swt.events.all;
import org.eclipse.swt.widgets.Event;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.swt.widgets.ColorDialog;
import org.eclipse.swt.graphics.Color : SWTColor = Color;
import org.eclipse.swt.layout.all;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.custom.ViewForm;
import org.eclipse.swt.widgets.Button;

import mainwindowgen;
import touchpad;
import controller;
import schedule;

class MainWindow : MainWindowGen {

    TouchpadWidget twid;

    DSColor ledColor;

    private DS5OutputState _outState;

    Schedule devConnListener;

    this(Display display){
        this.display = display;
        super(display);
        shell.setMinimumSize(new Point(650, 550));

        twid = new TouchpadWidget(compositeDispTouch, shell);
        
        foreach (c; controllers)
        {
            devsCombo.add(c.getTitle());
        }

        if(devsCombo.getItemCount > 0)
            devsCombo.select(0);
        
        devsCombo.addSelectionListener(new class SelectionAdapter {
            override void widgetSelected(SelectionEvent e) {
                int selectedIndex = devsCombo.getSelectionIndex();
                devsComboActivateSelection(selectedIndex);
            }
        });

        // todo: bind selected color to an outputstate
        buttonSetLedColor.addListener(SWT.Selection, new class() Listener {
            public void handleEvent(Event event) {
            ColorDialog colorDialog = new ColorDialog(shell);
            auto selectedRGB = colorDialog.open();
            if (selectedRGB !is null) {
                auto selectedColor = new SWTColor(display, selectedRGB);

                ledColor = DSColor(cast(ubyte)selectedColor.getRed,
                        cast(ubyte)selectedColor.getGreen, cast(ubyte)selectedColor.getBlue);
                selectedColor.dispose();

                DS5OutputState ostate = outState;
                ostate.lightbar = ledColor;
                outState = ostate;
            }
        }});

        spinnerLeftRumble.addModifyListener(new class ModifyListener {
            public void modifyText(ModifyEvent e){
                DS5OutputState ostate = outState;
                string sval = spinnerLeftRumble.getText();
                ostate.leftRumble = (sval == null || sval == "") ? 0 : sval.to!ubyte;
                outState = ostate;
            }
        });

        spinnerRightRumble.addModifyListener(new class ModifyListener {
            public void modifyText(ModifyEvent e){
                DS5OutputState ostate = outState;
                string sval = spinnerRightRumble.getText();
                ostate.rightRumble = (sval == null || sval == "") ? 0 : sval.to!ubyte;
                outState = ostate;
            }
        });

        buttonMic.addListener(SWT.Selection, new class() Listener {
            public void handleEvent(Event event) {
                DS5OutputState ostate = outState;

                if(outState.microphoneLed == MicLed.OFF)
                    ostate.microphoneLed = MicLed.ON;
                else if(outState.microphoneLed == MicLed.ON)
                    ostate.microphoneLed = MicLed.PULSE;
                else if(outState.microphoneLed == MicLed.PULSE)
                    ostate.microphoneLed = MicLed.OFF;
                
                outState = ostate;
            }
        });

        devConnListener = new Schedule(&checkAndUpdateDevConnections, 250);
    }

    void devsComboActivateSelection(int selectedIndex){
        foreach (controller; controllers) {
            controller.disconnectAll();
        }
        if(controllers.length)
            controllers[selectedIndex].connect(&watchControllerInput);
    }

    void checkAndUpdateDevConnections(){
        import std.algorithm.mutation : remove;
        // clear disconnected devices
        foreach_reverse (i, controller; controllers)
        {
            if(!controller.connected){
                devsCombo.remove(cast(int)i);
                controller.disconnect(&watchControllerInput);
                controllers = controllers.remove(i);
                devsCombo.select(0);
                devsComboActivateSelection(0);
            }
        }
        devsinfo[] = DeviceEnumInfo.init;
        auto numberOfDevs = findDevices(devsinfo[]);
        if(controllers.length != numberOfDevs){
            foreach (i; 0 .. numberOfDevs){
                if(controllers.length == 0){
                    auto newCont = new DSController(devsinfo[i]);
                    controllers ~= newCont;
                    devsCombo.add(newCont.getTitle);
                    devsCombo.select(0);
                    devsComboActivateSelection(0);
                }else{
                    auto clen = controllers.length;
                    foreach(k; 0..clen)
                    {
                        auto controller = controllers[k];
                        
                        if(!canFindDev(controllers, devsinfo[i])){
                            // new controller is connected
                            
                            auto newCont = new DSController(devsinfo[i]);
                            controllers ~= newCont;
                            devsCombo.add(newCont.getTitle);
                            auto newi = devsCombo.getChildrenCount();
                            devsCombo.select(newi);
                            devsComboActivateSelection(cast(int)newi);
                        }
                            
                    }
                }
                
            }
        }
    }

    void watchControllerInput(DS5InputState in_state){
        if(!controllers.length)
            return;
        auto _green = display.getSystemColor(SWT.COLOR_DARK_GREEN);

        void setBG(Widget)(Widget wid, int val){
            wid.setBackground(val ? _green : null);
            wid.redraw();
            wid.update();
        }
        setBG(labelLeft, in_state.buttonsAndDpad & DS5W_ISTATE_DPAD_LEFT);
        setBG(labelRight, in_state.buttonsAndDpad & DS5W_ISTATE_DPAD_RIGHT);
        setBG(labelUp, in_state.buttonsAndDpad & DS5W_ISTATE_DPAD_UP);
        setBG(labelDown, in_state.buttonsAndDpad & DS5W_ISTATE_DPAD_DOWN);

        setBG(labelR1, in_state.buttonsA & DS5W_ISTATE_BTN_A_RIGHT_BUMPER);
        setBG(labelL1, in_state.buttonsA & DS5W_ISTATE_BTN_A_LEFT_BUMPER);

        setBG(labelL3, in_state.buttonsA & DS5W_ISTATE_BTN_A_LEFT_STICK);
        setBG(labelR3, in_state.buttonsA & DS5W_ISTATE_BTN_A_RIGHT_STICK);

        setBG(labelM, in_state.buttonsA & DS5W_ISTATE_BTN_A_MENU);
        setBG(labelS, in_state.buttonsA & DS5W_ISTATE_BTN_A_SELECT);
        
        setBG(buttonMic, in_state.buttonsB & DS5W_ISTATE_BTN_B_MIC_BUTTON);
        setBG(labelPS, in_state.buttonsB & DS5W_ISTATE_BTN_B_PLAYSTATION_LOGO);
        
        if(in_state.leftTrigger > 0)
            setBG(labelL2, 1);
        else
            setBG(labelL2, 0);
        L2force.setText(format!"%d"(in_state.leftTrigger));
        if(in_state.rightTrigger > 0)
            setBG(labelR2, 1);
        else
            setBG(labelR2, 0);
        R2force.setText(format!"%d"(in_state.rightTrigger));


        setBG(labelX, in_state.buttonsAndDpad & DS5W_ISTATE_BTX_CROSS);
        setBG(labelSquare, in_state.buttonsAndDpad & DS5W_ISTATE_BTX_SQUARE);
        setBG(labelTriangle, in_state.buttonsAndDpad & DS5W_ISTATE_BTX_TRIANGLE);
        setBG(labelCircle, in_state.buttonsAndDpad & DS5W_ISTATE_BTX_CIRCLE);

        labelLX.setText(format!"%d"(in_state.leftStick.x));
        labelLY.setText(format!"%d"(in_state.leftStick.y));

        labelRX.setText(format!"%d"(in_state.rightStick.x));
        labelRY.setText(format!"%d"(in_state.rightStick.y));

        setBG(twid.canvas, in_state.buttonsB & DS5W_ISTATE_BTN_B_PAD_BUTTON);

        setBG(labelFnLeft, in_state.buttonsB & DS5W_ISTATE_BTN_B_FN_LEFT_BUTTON); // for edge controllers
        setBG(labelFnRight, in_state.buttonsB & DS5W_ISTATE_BTN_B_FN_RIGHT_BUTTON); // for edge controllers
        setBG(labelBottomLeft, in_state.buttonsB & DS5W_ISTATE_BTN_B_BOTTOM_LEFT_BUTTON); // for edge controllers
        setBG(labelBottomRight, in_state.buttonsB & DS5W_ISTATE_BTN_B_BOTTOM_RIGHT_BUTTON); // for edge controllers
        
        auto tp1 = new Point(in_state.touchPoint1.x, in_state.touchPoint1.y);
        auto tp2 = new Point(in_state.touchPoint2.x, in_state.touchPoint2.y);
        auto tp1id = in_state.touchPoint1.id;
        auto tp2id = in_state.touchPoint2.id;

        twid.setPoints(tp1, tp1id, tp2, tp2id);
        
        labelBatteryLevel.setText(format!"%d"(cast(int)in_state.battery.level));
        labelChargingStat.setText(in_state.battery.chargin ? "charging" : "not charging");
        labelFullYesNo.setText(in_state.battery.fullyCharged ? "Yes" : "No");

        labelAX.setText(format!"%d"(in_state.accelerometer.x));
        labelAY.setText(format!"%d"(in_state.accelerometer.y));
        labelAZ.setText(format!"%d"(in_state.accelerometer.z));

        labelGX.setText(format!"%d"(in_state.gyroscope.x));
        labelGY.setText(format!"%d"(in_state.gyroscope.y));
        labelGZ.setText(format!"%d"(in_state.gyroscope.z));

        labelHPhoneConnected.setText(in_state.headPhoneConnected ? "Yes" : "No");
        labelRY.getParent().redraw();
    }

    void open(){
        shell.open();

        addEventListeners();

        while (!shell.isDisposed()) {
            if (!display.readAndDispatch()) {
                display.sleep();
            }

            devConnListener.processAndRun;
            foreach (controller; controllers)
            {
                controller.updateInState();
            }
        }

        foreach (controller; controllers)
        {
            controller.disconnect(&watchControllerInput);
        }
        display.dispose();
    }

    void updateDevOutState(){
        if(!controllers.length)
            return;
        DS5OutputState _outs = outState;
        int selectedIndex = devsCombo.getSelectionIndex();
        auto con = controllers[selectedIndex].con;
        setDeviceOutputState(&con, &_outs);
    }

    DS5OutputState outState(){
        return _outState;
    }

    DS5OutputState outState(ref DS5OutputState out_state){
        if(_outState != out_state){
            _outState = out_state;
            updateDevOutState();
        }
        return out_state;
    }
}