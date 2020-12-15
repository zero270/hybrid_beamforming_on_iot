%Initialize system constants
rng(2014);
gc = helperGetDesignSpecsParameters();

%Tunable parameters
tp.txPower = 9;
tp.txGain = -8;
tp.mobileRange = 2750;
tp.mobileAngle = 3;
tp.interfPower = 1;
tp.interfGain = -20;
tp.interfRange = 9000;
tp.interfAngle = 20;
tp.numTXElements = 8;
tp.steeringAngle = 0;
tp.rxGain = 108.8320 - tp.txGain;

numTx = tp.numTXElements;

helperPlotMIMOEnvironment(gc, tp);

