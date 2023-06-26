module schedule;

import std.datetime.systime;
import core.time : msecs;

class Schedule {
    private SysTime lastRunTime;
    private void delegate() fun;
    private uint _msecs;

    this(void delegate() fun, uint _msecs) {
        this.fun = fun;
        this._msecs = _msecs;
        lastRunTime = Clock.currTime();
    }

    void processAndRun() {
        SysTime currentTime = Clock.currTime();
        auto elapsedTime = currentTime - lastRunTime;

        if (elapsedTime >= msecs(_msecs)) {
            fun();
            lastRunTime = currentTime;
        }
    }
}