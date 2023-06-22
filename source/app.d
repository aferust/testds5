import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;

import mainwindow;
import controller;
import ds5w;

void main()
{
    auto numberOfDevs = findDevices(devsinfo[]);

    foreach (i; 0 .. numberOfDevs)
    {
        controllers ~= new DSController(devsinfo[i]);
    }
    

    auto display = new Display;
    auto mainWindow = new MainWindow(display);

    if(controllers.length){
        controllers[0].connect(&mainWindow.watchControllerInput);
    }

    mainWindow.open();
}