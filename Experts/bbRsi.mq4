//+------------------------------------------------------------------+
//|                                                        bbRsi.mq4 |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
#include <TradeCalculation.mqh>

int magicNumber = 222;
input int bbPeriod = 50;

input int bandStdEntry = 2;
input int bandStdProfitExit = 1;
input int bandStdLossExit = 6;

int rsiPeriod = 14;
input double riskPerTrade = 0.02;
input int rsiLowerLevel = 40;
input int rsiUpperLevel = 60;

int openOrderId;

// test other 30 trades to make it more accurate
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
    Print("Starting Strategy BB 2 bands MR");
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
    Print("Stopping Strategy BB 2 bands MR");
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
    double bbLowerEntry = iBands(NULL, PERIOD_CURRENT, bbPeriod, bandStdEntry, 0, PRICE_CLOSE, MODE_LOWER, 0);
    double bbUpperEntry = iBands(NULL, PERIOD_CURRENT, bbPeriod, bandStdEntry, 0, PRICE_CLOSE, MODE_UPPER, 0);
    double bbMid = iBands(NULL, PERIOD_CURRENT, bbPeriod, bandStdEntry, 0, PRICE_CLOSE, MODE_MAIN, 0);
    
    double bbLowerProfitExit = iBands(NULL, PERIOD_CURRENT, bbPeriod, bandStdProfitExit, 0, PRICE_CLOSE, MODE_LOWER, 0);
    double bbUpperProfitExit = iBands(NULL, PERIOD_CURRENT, bbPeriod, bandStdProfitExit, 0, PRICE_CLOSE, MODE_UPPER, 0);
    
    double bbLowerLossExit = iBands(NULL, PERIOD_CURRENT, bbPeriod, bandStdLossExit, 0, PRICE_CLOSE, MODE_LOWER, 0);
    double bbUpperLossExit = iBands(NULL, PERIOD_CURRENT, bbPeriod, bandStdLossExit, 0, PRICE_CLOSE, MODE_UPPER, 0);
    
    double rsiValue = iRSI(NULL, PERIOD_CURRENT, rsiPeriod, PRICE_CLOSE, 0);

    if(IsTradingAllowed()) {
      if(!checkOpenOrderByMagicNumber(magicNumber)) {

        // long position
        if(Ask < bbLowerEntry && Open[0] > bbLowerEntry && rsiValue < rsiLowerLevel) {
          Print("");
          Print("Price is below bbLower and rsiValue is lower than " + rsiLowerLevel +" , sending buy order");

          double stopLossPrice = NormalizeDouble(bbLowerLossExit, Digits);
          double takeProfitPrice = NormalizeDouble(bbUpperProfitExit, Digits);

          Print("Entry price : " + Ask);
          Print("Stop loss price : " + stopLossPrice);
          Print("Take profit price : " + takeProfitPrice);

          double lotSize = optimalLotSize(riskPerTrade, Ask, stopLossPrice);

          openOrderId = OrderSend(NULL, OP_BUYLIMIT, lotSize, Ask, 10, stopLossPrice, takeProfitPrice, NULL, magicNumber);
          if(openOrderId < 0) Alert("Order rejected, Order error: " + GetLastError());
        }
        // short position
        else if(Bid > bbUpperEntry && Open[0] < bbUpperEntry && rsiValue > rsiUpperLevel) {
          Print("");
          Print("Price is above bbUpper and rsiValue is above than " + rsiUpperLevel +" , sending sell order");

          double stopLossPrice = NormalizeDouble(bbUpperLossExit, Digits);
          double takeProfitPrice = NormalizeDouble(bbLowerProfitExit, Digits);

          Print("Entry price : " + Bid);
          Print("Stop loss price : " + stopLossPrice);
          Print("Take profit price : " + takeProfitPrice);

          double lotSize = optimalLotSize(riskPerTrade, Bid, stopLossPrice);

          openOrderId = OrderSend(NULL, OP_SELLLIMIT, lotSize, Bid, 10, stopLossPrice, takeProfitPrice, NULL, magicNumber);
          if(openOrderId < 0) Alert("Order rejected, Order error: " + GetLastError());
        }
      } else {
        if(OrderSelect(openOrderId, SELECT_BY_TICKET) == true) {
          int orderType = OrderType();

          double optimalTakeProfit;

          // add a check to make sure the take profit is not negative
          if(orderType == OP_BUY) { // WHAT ABOUT THE OTHER TYPE OF ORDER?? IF IT"S OP_BUYLIMIT???
            optimalTakeProfit = NormalizeDouble(bbUpperProfitExit, Digits);
          } else {
            optimalTakeProfit = NormalizeDouble(bbLowerProfitExit, Digits);
          }

          double tp = OrderTakeProfit();
          double tpDistance = MathAbs(tp - optimalTakeProfit);

          if(tp != optimalTakeProfit && tpDistance > 0.0001) {
            Print("Modify order");

            bool ans = OrderModify(openOrderId, OrderOpenPrice(), OrderStopLoss(), optimalTakeProfit, 0);

            if(ans) {
              Print("Order modified: " + openOrderId);
              return;
            } else {
              Print("Unable to modify order: " + openOrderId);
            }
          }
        }
      }
    }
  }
//+------------------------------------------------------------------+
