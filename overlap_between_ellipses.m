function ovl=overlap_between_ellipses(e1,e2,swt)

p1x=e1(1,:);
p1y=e1(2,:);
p2x=e2(1,:);
p2y=e2(2,:);

[~, ~, z0ind, z1ind]=meetpoint(p1x,p1y,p2x,p2y);
a_e0=polyarea(p1x,p1y);
a_e1=polyarea(p2x,p2y);

if numel(z0ind)==0
    if (a_e0>a_e1 && sum(inpolygon(p2x,p2y,p1x,p1y))==0) ||...
            (a_e0<a_e1 && sum(inpolygon(p1x,p1y,p2x,p2y))==0)
        a_int=0;
        x=[];
        y=[];
    else
        a_int=min([a_e0 a_e1]);
        x=p2x;
        y=p2y;
    end
    
elseif numel(z0ind)==2
    xp1=p2x(z1ind(1):z1ind(2));
    yp1=p2y(z1ind(1):z1ind(2));
    
    if z0ind(2)<z0ind(1)
        xp2=p1x(z0ind(2):z0ind(1));
        yp2=p1y(z0ind(2):z0ind(1));
    else
        xp2=p1x([z0ind(2):end 1:z0ind(1)]);
        yp2=p1y([z0ind(2):end 1:z0ind(1)]);
    end
    x=[xp1 xp2];
    y=[yp1 yp2];
    a_int=polyarea(x,y);
    
elseif numel(z0ind)==4
    xp1=p2x(z1ind(1):z1ind(2));
    yp1=p2y(z1ind(1):z1ind(2));
    
    if z0ind(2)<z0ind(3)
        xp2=p1x(z0ind(2):z0ind(3));
        yp2=p1y(z0ind(2):z0ind(3));
    else
        xp2=p1x([z0ind(2):end 1:z0ind(3)]);
        yp2=p1y([z0ind(2):end 1:z0ind(3)]);
    end
    
    xp3=p2x(z1ind(3):z1ind(4));
    yp3=p2y(z1ind(3):z1ind(4));
    
    if z0ind(4)<z0ind(1)
        xp4=p1x(z0ind(4):z0ind(1));
        yp4=p1y(z0ind(4):z0ind(1));
    else
        xp4=p1x([z0ind(4):end 1:z0ind(1)]);
        yp4=p1y([z0ind(4):end 1:z0ind(1)]);
    end
    x=[xp1 xp2 xp3 xp4];
    y=[yp1 yp2 yp3 yp4];
    a_int=polyarea(x,y);
end

if a_int/(a_e0+a_e1-a_int)>1
    
    p1xd=p2x;
    p1yd=p2y;
    p2x=p1x;
    p2y=p1y;
    p1x=p1xd;
    p1y=p1yd;
    
    [~, ~, z0ind, z1ind]=meetpoint(p1x,p1y,p2x,p2y);
    
    if numel(z0ind)==2
        xp1=p2x(z1ind(1):z1ind(2));
        yp1=p2y(z1ind(1):z1ind(2));
        
        if z0ind(2)<z0ind(1)
            xp2=p1x(z0ind(2):z0ind(1));
            yp2=p1y(z0ind(2):z0ind(1));
        else
            xp2=p1x([z0ind(2):end 1:z0ind(1)]);
            yp2=p1y([z0ind(2):end 1:z0ind(1)]);
        end
        x=[xp1 xp2];
        y=[yp1 yp2];
        a_int=polyarea(x,y);
        
    elseif numel(z0ind)==4
        xp1=p2x(z1ind(1):z1ind(2));
        yp1=p2y(z1ind(1):z1ind(2));
        
        if z0ind(2)<z0ind(3)
            xp2=p1x(z0ind(2):z0ind(3));
            yp2=p1y(z0ind(2):z0ind(3));
        else
            xp2=p1x([z0ind(2):end 1:z0ind(3)]);
            yp2=p1y([z0ind(2):end 1:z0ind(3)]);
        end
        
        xp3=p2x(z1ind(3):z1ind(4));
        yp3=p2y(z1ind(3):z1ind(4));
        
        if z0ind(4)<z0ind(1)
            xp4=p1x(z0ind(4):z0ind(1));
            yp4=p1y(z0ind(4):z0ind(1));
        else
            xp4=p1x([z0ind(4):end 1:z0ind(1)]);
            yp4=p1y([z0ind(4):end 1:z0ind(1)]);
        end
        x=[xp1 xp2 xp3 xp4];
        y=[yp1 yp2 yp3 yp4];
        
        a_int=polyarea(x,y);
    end
end

if a_int/(a_e0+a_e1-a_int)>1
    
    [~, ~, z0ind, z1ind]=meetpoint(p1x,p1y,p2x,p2y);
    if numel(z0ind)==2
        if z0ind(1)<z0ind(2)
            xp1=p1x(z0ind(1):z0ind(2));
            yp1=p1y(z0ind(1):z0ind(2));
        else
            xp1=p1x([z0ind(1):end 1:z0ind(2)]);
            yp1=p1y([z0ind(1):end 1:z0ind(2)]);
        end
        
        if z1ind(2)<z1ind(1)
            xp2=p2x(z1ind(2):z1ind(1));
            yp2=p2y(z1ind(2):z1ind(1));
        else
            xp2=p2x([z1ind(2):end 1:z1ind(1)]);
            yp2=p2y([z1ind(2):end 1:z1ind(1)]);
        end
        
        x=[xp1 xp2];
        y=[yp1 yp2];
        a_int=polyarea(x,y);
        
    elseif numel(z0ind)==4
        if z0ind(1)<z0ind(2)
            xp1=p1x(z0ind(1):z0ind(2));
            yp1=p1y(z0ind(1):z0ind(2));
        else
            xp1=p1x([z0ind(1):end 1:z0ind(2)]);
            yp1=p1y([z0ind(1):end 1:z0ind(2)]);
        end
        
        xp2=p2x(z1ind(2):z1ind(3));
        yp2=p2y(z1ind(2):z1ind(3));
        
        xp3=p1x(z0ind(3):z0ind(4));
        yp3=p1y(z0ind(3):z0ind(4));
        
        if z1ind(4)<z1ind(1)
            xp4=p2x(z1ind(4):z1ind(1));
            yp4=p2y(z1ind(4):z1ind(1));
        else
            xp4=p2x([z1ind(4):end 1:z1ind(1)]);
            yp4=p2y([z1ind(4):end 1:z1ind(1)]);
        end
        x=[xp1 xp2 xp3 xp4];
        y=[yp1 yp2 yp3 yp4];
        
        a_int=polyarea(x,y);
    end
    
end

ovl= a_int/min(a_e0,a_e1); %modified 05/11/18 Set the ratio type to 'Min' to compute the ratio as the area of intersection between bboxA and bboxB, divided by the minimum area of the two bounding boxes.
%ovl=a_int/(a_e0+a_e1-a_int); Set the ratio type to 'Union' to compute the ratio as the area of intersection between bboxA and bboxB, divided by the area of the union of the two.

if swt
    figure(23)
    plot(p1x,p1y,'b')
    hold on
    plot(p2x,p2y,'r')
    plot(x,y,'g')
    title(ovl)
    hold off
end