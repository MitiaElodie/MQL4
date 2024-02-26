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
    double takeProfit = Ask + 0.01;
    double stopLoss = Ask - 0.01;

    int orderId = OrderSend(NULL, OP_BUYLIMIT, 0.01, Ask, 10, stopLoss, takeProfit);

    for (int i = 0; i < 5; i++)
    {
      Sleep(1000);
      takeProfit += 0.01;
      stopLoss -= 0.01;
      OrderModify(orderId, 0, stopLoss, takeProfit, NULL, NULL);
    }
    
  }
//+------------------------------------------------------------------+
