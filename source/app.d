import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;

import mainwindow;

void main()
{
    auto display = new Display;
    auto mainWindow = new MainWindow(display);
    mainWindow.open();
}