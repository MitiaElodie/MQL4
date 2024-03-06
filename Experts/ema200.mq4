//+------------------------------------------------------------------+
//|                                                       ema200.mq4 |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <TradeCalculation.mqh>

int magicNumber = 333;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
    if(IsTradingAllowed()) {
      if(!checkOpenOrderByMagicNumber(magicNumber)) {
        double ema200 = iMA(NULL, PERIOD_CURRENT, 200, 0, MODE_EMA, PRICE_CLOSE, 0);
        double ema50 = iMA(NULL, PERIOD_CURRENT, 50, 0, MODE_EMA, PRICE_CLOSE, 0);
        Alert("ema200: " + ema200);
        Alert("ema50: " + ema50);

        // TODO add check for when we took a SL and the price is still in the entry zone
        int orderId;
        if(Ask > ema200 && ema50 > ema200) {
          Alert("Buy");
        } else if(Bid < ema200 && ema50 < ema200) {
          Alert("Sell");
        }
      }
    }
  }
//+------------------------------------------------------------------+
