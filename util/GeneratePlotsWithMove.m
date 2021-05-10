unction GeneratePlotsWithMove( n, xt , yt , xcoord , ycoord , r , move, cons)
figure(1)
%pause(0.2)
hold off
plot(xt, yt,'LineWidth',2) % polygon
bufferx = 0.1*(max(xt)-min(xt));
buffery = 0.1*(max(yt)-min(yt));
xlim([min(xt)-bufferx,max(xt)+bufferx])
ylim([min(yt)-buffery,max(yt)+buffery])
text(min(xt)-0.5*bufferx,min(yt)-0.5*buffery,strcat('r=',num2str(r)))
axis equal
hold on
for j = 1:n
    text(-1,3,strcat('r=',num2str(r)))
    text(-1,2,strcat('n=',num2str(n)))
    [xc, yc] = circle([xcoord(j)  ycoord(j)], r , 1000);
    plot(xc, yc)
    plot(xcoord(j),ycoord(j),'r*')
    hold on
    p0 = [xcoord(j) ycoord(j)];
    p1 = p0+move(j,:);
    plot([p0(1),p1(1)],[p0(2),p1(2)])
    hold on
end
for i = 1:length(cons)
    con = cons(i,:);
    plot([xcoord(con(1)), xcoord(con(2))], [ycoord(con(1)), ycoord(con(2))])
    [xc, yc] = circle([xcoord(con(1))  ycoord(con(1))], con(3) , 1000);
    plot(xc, yc, 'g')
    [xc, yc] = circle([xcoord(con(1))  ycoord(con(1))], con(4) , 1000);
    plot(xc, yc, 'r')
    drawnow
title('Circle Packing in a Triangle at t = t0')
end