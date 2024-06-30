clear all;

% Question 1 %
NewYork = getMarketDataViaYahoo('NYT','1-Jan-1985','31-Dec-2021','1d');
P = NewYork.Close;
dates = NewYork.Date;
dates2 = dates(2:end,:);
r = 100*(log(P(2:end)) - log(P(1:end-1)));

% GARCH(1,1) %
GARCH1 = garch('GARCHLags',1,'ARCHLags',1,'Offset',NaN);
estGARCH1 = estimate(GARCH1,r);
v1 = sqrt(infer(estGARCH1,r));
garch_1_1=summarize(estGARCH1);

% GARCH(2,3) %
GARCH2 = garch('GARCHLags',1:2,'ARCHLags',1:3,'Offset',NaN);
estGARCH2 = estimate(GARCH2,r);
v2 = sqrt(infer(estGARCH2,r));
garch_2_3=summarize(estGARCH2);

% estimating volatility and more GARCH(1,1)%
v1 = sqrt(infer(estGARCH1,r));
e=r-estGARCH1.Offset;
eps=e./v1;

figure(1);
plot(dates2,e);
ylim([0 30]);
ylabel('Percentage Return');
title('Estimated Residual using GARCH(1,1)');
box off

figure(2);
plot(dates2,v1);
ylim([0 15]);
ylabel('Percentage Return');
title('Estimated Standard Deviation using GARCH(1,1)');
box off

figure(3);
plot(dates2,eps);
ylim([0 15]);
ylabel('Percentage Return');
title('Estimated Innovation using GARCH(1,1)');
box off

% density of eps %
figure(4);
[f,x] = ksdensity(eps,(-4:.1:4));
g = normpdf(x);
plot(x,f,'--',x,g,'-.');
title('Density Plots');
legend('Epsilon','N(0,1)','Location','northeast');
box off

% Question 2 %
GARCH1_t = garch('GARCHLags',1,'ARCHLags',1,'Offset',NaN,'Distribution','t');
estGARCH1_t = estimate(GARCH1_t,r);


% Question 3 %
mdl = gjr('GARCHLags',1,'LeverageLags',1,'ARCHLags',1,'Offset',NaN,'Distribution','t'); 
est_mdl = estimate(mdl,r,'display','off');
summarize(est_mdl);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function data=getMarketDataViaYahoo(symbol, startdate, enddate, interval)
    if(nargin() == 1)
        startdate = posixtime(datetime('1-Jan-2018'));
        enddate = posixtime(datetime()); % now
        interval = '1d';
    elseif (nargin() == 2)
        startdate = posixtime(datetime(startdate));
        enddate = posixtime(datetime()); % now
        interval = '1d';
    elseif (nargin() == 3)
        startdate = posixtime(datetime(startdate));
        enddate = posixtime(datetime(enddate));        
        interval = '1d';
    elseif(nargin() == 4)
        startdate = posixtime(datetime(startdate));
        enddate = posixtime(datetime(enddate));
    else
        error('At least one parameter is required. Specify ticker symbol.');
        data = [];
        return;
    end
    
    %% Send a request for data
    % Construct an URL for the specific data
    uri = matlab.net.URI(['https://query1.finance.yahoo.com/v7/finance/download/', upper(symbol)],...
        'period1',  num2str(int64(startdate), '%.10g'),...
        'period2',  num2str(int64(enddate), '%.10g'),...
        'interval', interval,...
        'events',   'history',...
        'frequency', interval,...
        'guccounter', 1,...
        'includeAdjustedClose', 'true');  
    
    options = weboptions('ContentType','table', 'UserAgent', 'Mozilla/5.0');
    try
        data = rmmissing(webread(uri.EncodedURI, options));
    catch ME
        data = [];
        warning(['Identifier: ', ME.identifier, 'Message: ', ME.message])
    end 
end