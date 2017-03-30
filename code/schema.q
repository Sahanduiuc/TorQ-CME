/ schema for defitions table from "d" msgs, quote table, trade table

\d .schema

definitions:([] 
 TradeDate:`date$();
 LastUpdateTime:`timestamp$();
 MatchEventIndicator:`int$();
 SecurityUpdateAction:`$();
 MarketSegmentID:`int$();
 Symbol:`$();
 SecurityID:`int$();
 MaturityMonthYear:`month$();
 SecurityGroup:`$();
 SecurityType:`$();
 UnderlyingProduct:`int$();
 SecurityExchange:`$();
 Currency:`$();
 MarketDepth:`int$();
 DisplayFactor:`float$());

quote:([] 
 TradeDate:`date$();
 MsgSeqNum:`int$();
 TransactTime:`timestamp$();
 MatchEventIndicator:`int$();
 MDUpdateAction:`$();
 MDEntryType:`$();
 SecurityID:`int$();
 Symbol:`$();
 RptSeq:`int$();
 MDEntryPx:`float$();
 MDEntrySize:`float$();
 NumberOfOrders:`int$();
 MDPriceLevel:`int$());

trade:([] 
 TradeDate:`date$();
 MsgSeqNum:`int$();
 TransactTime:`timestamp$();
 MatchEventIndicator:`int$();
 MDUpdateAction:`$();
 SecurityID:`int$();
 Symbol:`$();
 RptSeq:`int$();
 MDEntryPx:`float$();
 MDEntrySize:`float$();
 NumberOfOrders:`int$();
 AggressorSide:`$());

status:([] 
 MsgSeqNum:`int$();
 TransactTime:`timestamp$();
 TradingDate:`date$();
 MatchEventIndicator:`int$();
 SecurityGroup:`$();
 SecurityTradingStatus:`$();
 HaltReasonChar:`$();
 SecurityTradingEvent:`$());

init:{[] 
 .raw.definitions:.schema.definitions;
 .raw.quote:.schema.quote;
 .raw.trade:.schema.trade;
 .raw.status:.schema.status;
 }

savetype:(!) . flip (
  `.raw.quote`partitioned;
  `.raw.trade`partitioned;
  `.raw.definitions`splay;
  `.raw.status`splay
 );

/ field mappings for user-friendly trade table
trfieldmaps:(!) . flip (
  `date`TradeDate;
  `time`TransactTime;
  `sym`Symbol;
  `price`MDEntryPx;
  `size`MDEntrySize;
  `orders`NumberOfOrders;
  `side`AggressorSide;
  `msgseq`MsgSeqNum;
  `rptseq`RptSeq;
  `matchevent`MatchEventIndicator
 );

/ field mappings for user-friendly quote/book table
qtfieldmaps:(!) . flip (
  `date`TradeDate;
  `time`TransactTime;
  `sym`Symbol;
  `bprice`bprice;
  `bsize`bsize;
  `aprice`aprice;
  `asize`asize;
  `msgseq`MsgSeqNum;
  `rptseq`RptSeq;
  `matchevent`MatchEventIndicator
 );