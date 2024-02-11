//+------------------------------------------------------------------+
//|                                                    Variables.mq4 |
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
   Alert("Account balance: " + AccountBalance());
   Alert("Account server: " + AccountServer());
   Alert("Mode stop level: " + MarketInfo(NULL, MODE_STOPLEVEL));
  }
//+------------------------------------------------------------------+
