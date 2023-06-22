module controller;

import std.stdio;

public import ds5w;

__gshared DeviceEnumInfo[16] devsinfo;
__gshared DSController[] controllers;

size_t findDevices(DeviceEnumInfo[] devsinfo)
{
    size_t controllersCount;
    auto rv = enumDevices(devsinfo, &controllersCount);

    if (controllersCount == 0)
    {
        writeln("No DualSense controller found!");
        return 0;
    }

    // Print all controllers
    writeln("Found ", controllersCount, " DualSense Controller(s):");

    foreach (i; 0 .. controllersCount)
    {
        if (devsinfo[i]._internal.connection == DeviceConnection.BT)
        {
            "Wireless (Bluetooth) controller (".writeln;
        }
        else
        {
            "Wired (USB) controller (".writeln;
        }

        writeln(devsinfo[i]._internal.path ~ ")");
    }

    return controllersCount;
}

import std.signals;

class DSController
{
    bool connected;

    DeviceEnumInfo info;
    DeviceContext con;
    private DS5InputState _inState;
    //private DS5OutputState _outState;

    this(DeviceEnumInfo info)
    {
        this.info = info;

        if (DS5W_SUCCESS(initDeviceContext(&info, &con)))
        {
            connected = true;
        }
    }

    DeviceConnection getConnectionType()
    {
        return info._internal.connection;
    }

    DEVICE_VARIANT getDeviceVariant()
    {
        return con.variant;
    }

    string getTitle()
    {
        auto var = getDeviceVariant() == DEVICE_VARIANT.DS_EDGE ? "Edge" : "Regular";
        auto cnn = getConnectionType() == DeviceConnection.USB ? "USB" : "BT";

        return "DualSense " ~ var ~ " Controller " ~ "(" ~ cnn ~ ")";
    }

    void updateInState(){
        DS5InputState _ins;
        getDeviceInputState(&con, &_ins);
        inState = _ins;
    }

    DS5InputState inState(){
        return _inState;
    }

    DS5InputState inState(ref DS5InputState in_state){
        if(_inState != in_state){
            _inState = in_state;
            emit(in_state);
        }
        return in_state;
    }

    mixin Signal!(DS5InputState);
}