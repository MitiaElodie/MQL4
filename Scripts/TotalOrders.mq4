//+------------------------------------------------------------------+
//|                                                  TotalOrders.mq4 |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <TradeCalculation.mqh>

int magicNumber = 222;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
    Alert("");

    Alert("Order open with magic number : " + checkOpenOrderByMagicNumber(magicNumber));
    if(checkOpenOrderByMagicNumber(magicNumber)) {
      Alert("Already order opened, do not send more orders");
    } else {
      OrderSend(NULL, OP_BUY, 0.01, Ask, 0.1, Ask - 0.01, Ask + 0.01, 0, magicNumber);
    }
    
    // if(openOrders < 1) {
    //   Alert("No order open");
    // } else {
    //   Alert("There is already an open order, do not send one");
    // }
  }
//+------------------------------------------------------------------+
