function excelToGraph(filename)

    %make sure to delete duplicate date values! 

    %===formatting ca===
    ca = readcell(filename);
    headers = ca(1,:);
    for h = 1:length(headers)
        switch headers{h}
            case 'Date'
                first = [ca(:,h)];
            case 'Source'
                second = [ca(:,h)];
            case 'Daily Mean PM2.5 Concentration'
                third = [ca(:,h)];
            case 'Daily AQI Value'
                fourth = [ca(:,h)];
            case 'Local Site Name'
                fifth = [ca(:,h)];
        end
    end
    ca = [first second third fourth fifth];
    data = ca(2:end,:);
    %===split sites, split sources, and plot===
    tempAQSCa = {};
    tempAirNowCa = {};
    tempCa = data(1,:);
    hasAQS = {};
    hasAirNow = {};
    for i = 2:length(data)
        if i == length(data)
            tempSources = tempCa(:,2);
            if any(strcmp(tempSources,'AQS'))
                AQSMask = strcmp(tempSources,'AQS');
                tempAQSCa = tempCa(AQSMask,:);

                xvals = [tempAQSCa{2:end,1}];
                yvals = [tempAQSCa{2:end,3}];
                subplot(2,2,1)
                hold on
                plot(xvals,yvals)
    
                yvals = [tempAQSCa{2:end,4}];
                subplot(2,2,3)
                hold on
                plot(xvals,yvals)

                hasAQS = [hasAQS data((i-1),5)];
            end
            if any(strcmp(tempSources,'AirNow'))
                AirNowMask = strcmp(tempSources,'AirNow');
                tempAirNowCa = tempCa(AirNowMask,:);
                
                xvals = [tempAirNowCa{2:end,1}];
                yvals = [tempAirNowCa{2:end,3}];
                subplot(2,2,2)
                hold on
                plot(xvals,yvals)
    
                yvals = [tempAirNowCa{2:end,4}];
                subplot(2,2,4)
                hold on
                plot(xvals,yvals)

                hasAirNow = [hasAirNow data((i-1),5)];
            end
        elseif strcmp(data(i,5),data((i-1),5))
            tempCa = [tempCa; data(i,:)];
        else
            tempSources = tempCa(:,2);
            if any(strcmp(tempSources,'AQS'))
                AQSMask = strcmp(tempSources,'AQS');
                tempAQSCa = tempCa(AQSMask,:);

                xvals = [tempAQSCa{2:end,1}];
                yvals = [tempAQSCa{2:end,3}];
                subplot(2,2,1)
                hold on
                plot(xvals,yvals)
    
                yvals = [tempAQSCa{2:end,4}];
                subplot(2,2,3)
                hold on
                plot(xvals,yvals)

                hasAQS = [hasAQS data((i-1),5)];
            end
            if any(strcmp(tempSources,'AirNow'))
                AirNowMask = strcmp(tempSources,'AirNow');
                tempAirNowCa = tempCa(AirNowMask,:);
                
                xvals = [tempAirNowCa{2:end,1}];
                yvals = [tempAirNowCa{2:end,3}];
                subplot(2,2,2)
                hold on
                plot(xvals,yvals)
    
                yvals = [tempAirNowCa{2:end,4}];
                subplot(2,2,4)
                hold on
                plot(xvals,yvals)

                hasAirNow = [hasAirNow data((i-1),5)];
            end
            tempCa = data(i,:);
        end
    end
    %===format graphs===
    subplot(2,2,1)
    xlabel('Date')
    ylabel('PM2.5 Concentration (ug/m3)')
    legend(hasAQS{1:length(hasAQS)})
    title('PM2.5 Concentration in 2024 (AQS)')

    subplot(2,2,2)
    xlabel('Date')
    ylabel('PM2.5 Concentration (ug/m3)')
    legend(hasAirNow{1:length(hasAirNow)})
    title('PM2.5 Concentration in 2024 (AirNow)')

    subplot(2,2,3)
    xlabel('Date')
    ylabel('Daily AQI Value')
    legend(hasAQS{1:length(hasAQS)})
    title('Daily AQI Values in 2024 (AQS)')

    subplot(2,2,4)
    xlabel('Date')
    ylabel('Daily AQI Value')
    legend(hasAirNow{1:length(hasAirNow)})
    title('Daily AQI Values in 2024 (AirNow)')

    hold off
end