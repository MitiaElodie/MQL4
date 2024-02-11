//+------------------------------------------------------------------+
//|                                                sendingOrders.mq4 |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <TradeCalculation.mqh>
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
{
//---
  Alert("");
  // check if AutoTrading is enabled, otherwise, the orders will not be send
  // IsTradeAllowed()
  // check if the market is open for the specified pair at the specified time
  // IsTradeAllowed(NULL, TimeCurrent()
  // Alert(IsTradingAllowed());
  // Alert(SymbolInfoDouble(NULL, SYMBOL_TRADE_CONTRACT_SIZE));
  // Alert(MarketInfo(NULL, MODE_MINLOT));
  
}
//+------------------------------------------------------------------+
