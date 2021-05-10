function ret = drawPoints
    scz=get(0,'ScreenSize');
    fig=figure('Position',[round(scz(1,3)/4) round(scz(1,4)/8) 700 500],'NumberTitle','off','Name','Draw vertices (double-click at last vertex)','Resize','off');
    xlim([0,10])
    ylim([0,10])
    [x, y] = getline(fig);
    L = length(x);
    if L < 3
        error('Shape not a polygon: not enough vertices!')
    end
    pts = zeros(L,2);
    for i = 1:L
        pts(i,1) = x(i);
        pts(i,2) = y(i);
    end
    pgon = polyshape(pts,'Simplify',false);
    if ~issimplified(pgon)
        disp('Shape not a simple polygon: intersecting edges!')
        close(fig)
        ret = drawPoints;
        return
    end
    ret = pts';
    close all
end