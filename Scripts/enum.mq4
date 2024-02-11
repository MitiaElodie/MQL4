//+------------------------------------------------------------------+
//|                                                         enum.mq4 |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs

enum ENUM_TRADING_METHOD { Very_Aggressive, Aggressive, Normal, Passive, Very_passive};
input ENUM_TRADING_METHOD myTradingMethod = Aggressive;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
    Alert("My trading method is " + myTradingMethod);
  }
//+------------------------------------------------------------------+
