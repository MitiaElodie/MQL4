//+------------------------------------------------------------------+
//|                                                        Array.mq4 |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
    // Alert("Open[0] :" + Open[0]);
    // Alert("High[0] :" + High[0]);
    // Alert("Low[0] :" + Low[0]);
    // Alert("Close[0] :" + Close[0]);
    // Alert("Volume[0] :" + Volume[0]);
    // Alert("Time[0] :" + Time[0]);
    Alert("");
    for(int i = 0; i < Bars; i++) {
      Alert(Time[i] + " " + Open[i] + " " + High[i] + " " + Low[i] + " " + Close[i] + " " + Volume[i]);
    }
    Alert(Bars);
  }
//+------------------------------------------------------------------+
