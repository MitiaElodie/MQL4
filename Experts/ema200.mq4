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
#include <DisplayFunctions.mqh>

int magicNumber = 333;
double ratio = 2;
double maxLossPercentage = 0.01;
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
        // TODO add check if we are too close to ema 200

        int openOrderId;

        if(Ask > ema200 && ema50 > ema200 && Ask < ema50 && Open[0] > ema50) {
          int firstPeakIndex = findFirstPeakIndex();
          double tpPrice = High[firstPeakIndex];
          double slPrice = calculateStopLossPriceFromRatio(Ask, tpPrice, ratio);
          double lotSize = optimalLotSize(maxLossPercentage, Ask, slPrice);

          openOrderId = OrderSend(NULL, OP_BUYLIMIT, lotSize, Ask, 10, slPrice, tpPrice, NULL, magicNumber);
          if(openOrderId < 0) Alert("Order rejected, Order error: " + GetLastError());
        
        } else if(Bid < ema200 && ema50 < ema200 && Bid > ema50 && Open[0] < ema50) {
          int firstLowIndex = findFirstLowIndex();
          double tpPrice = Low[firstLowIndex];
          double slPrice = calculateStopLossPriceFromRatio(Ask, tpPrice, ratio);
          double lotSize = optimalLotSize(maxLossPercentage, Bid, slPrice);

          openOrderId = OrderSend(NULL, OP_SELLLIMIT, lotSize, Bid, 10, slPrice, tpPrice, NULL, magicNumber);
          if(openOrderId < 0) Alert("Order rejected, Order error: " + GetLastError());
          
        }
      }
    }
  }
//+------------------------------------------------------------------+
