function [max_x, max_y, min_x, min_y] = mypredict(data_x, data_y, ex_max_x, ex_max_y, ex_min_x, ex_min_y);

l_ma=length(ex_max_x);
l_mi=length(ex_min_x);
% std_max_y=std(ex_max_y);
% std_min_y=std(ex_min_y);

if l_ma > 2;
    sda=2;
else
    sda=l_ma-1;
end

if l_mi > 2;
    sdi=2;
else
    sdi=l_mi-1;
end

m_maxEY=mean(ex_max_y(end-sda:end));
m_minEY=mean(ex_min_y(end-sdi:end));
d_EY=abs((m_maxEY-m_minEY)/2);

m_maxBY=mean(ex_max_y(1:sda+1));
m_minBY=mean(ex_min_y(1:sdi+1));
d_BY=abs((m_maxBY-m_minBY)/2);

    if l_ma >=2; % l_ma >=2
        %============end============================================
        m_maxEX=round(mean(diff(ex_max_x(end-sda:end))));
        p_maxEX=NaN(1,2);
        p_maxEX(1)=ex_max_x(end)+ceil((data_x(end)-ex_max_x(end))/m_maxEX)*m_maxEX;
        p_maxEX(2)=p_maxEX(1)+m_maxEX;
        
        if  data_y(end-1) < data_y(end) & data_y(end) > m_maxEY;
            p_maxEY=ones(1,2)*data_y(end);
        else
            p_maxEY=ones(1,2)*m_maxEY;
        end
        %============begin==========================================
        m_maxBX=round(mean(diff(ex_max_x(1:sda+1))));
        p_maxBX=NaN(1,2);
        p_maxBX(2)=ex_max_x(1)-ceil((ex_max_x(1)-data_x(1))/m_maxBX)*m_maxBX;
        p_maxBX(1)=p_maxBX(2)-m_maxBX;
        
        if  m_maxBY < data_y(1) & data_y(1) > data_y(2);
            p_maxBY=ones(1,2)*data_y(1);
        else
            p_maxBY=ones(1,2)*m_maxBY;
        end
    else % l_ma == 1
        %============end============================================
        p_maxEX=[data_x(end)];
%         p_maxEY=[ex_max_y(end)];
        if  ex_max_y(end) < data_y(end);
            p_maxEY=data_y(end);
        else
            p_maxEY=ex_max_y(end);
        end

        %============begin==========================================
        p_maxBX=[data_x(1)];
%        p_maxBY=[ex_max_y(1)];
        if  ex_max_y(1) < data_y(1);
            p_maxBY=data_y(1);
        else
            p_maxBY=ex_max_y(1);
        end
    end
   
    
    if l_mi >=2; % l_mi >= 2;
        %============end============================================
        m_minEX=round(mean(diff(ex_min_x(end-sdi:end))));
        p_minEX=NaN(1,2);
        p_minEX(1)=ex_min_x(end)+ceil((data_x(end)-ex_min_x(end))/m_minEX)*m_minEX;
        p_minEX(2)=p_minEX(1)+m_minEX;
        if  data_y(end-1) > data_y(end) & data_y(end) < m_minEY;
            p_minEY=ones(1,2)*data_y(end);
        else
            p_minEY=ones(1,2)*m_minEY;
        end
        %============begin==========================================
        m_minBX=round(mean(diff(ex_min_x(1:sdi+1))));
        p_minBX=NaN(1,2);
        p_minBX(2)=ex_min_x(1)-ceil((ex_min_x(1)-data_x(1))/m_minBX)*m_minBX;
        p_minBX(1)=p_minBX(2)-m_minBX;
        if  m_minBY > data_y(1) & data_y(1) < data_y(2);
            p_minBY=ones(1,2)*data_y(1);
        else
            p_minBY=ones(1,2)*m_minBY;
        end
    else % l_mi == 1
        %============end============================================
        p_minEX=[data_x(end)];
 %       p_minEY=[ex_min_y(end)];
        if  ex_min_y(end) > data_y(end);
            p_minEY=data_y(end);
        else
            p_minEY=ex_min_y(end);
        end
 
 
        %============begin==========================================
        p_minBX=[data_x(1)];
 %       p_minBY=[ex_min_y(1)];
        if  ex_min_y(1) > data_y(1);
            p_minBY=data_y(1);
        else
            p_minBY=ex_min_y(1);
        end
    end

max_x=[p_maxBX,ex_max_x,p_maxEX];
max_y=[p_maxBY,ex_max_y,p_maxEY];
min_x=[p_minBX,ex_min_x,p_minEX];
min_y=[p_minBY,ex_min_y,p_minEY];