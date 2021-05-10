function [ xcoord, ycoord ] = GetPointsInside( n, xt, yt )
xcoord = (max(xt)-min(xt))*rand(n,1)+min(xt);
ycoord = (max(yt)-min(yt))*rand(n,1)+min(yt);
[in,~] = inpolygon(xcoord,ycoord,xt,yt);
n_in = numel(xcoord(in));
while n_in ~= n
    xcoord(~in) = (max(xt)-min(xt))*rand(n-n_in,1)+min(xt);
    ycoord(~in) = (max(yt)-min(yt))*rand(n-n_in,1)+min(yt);
    [in,~] = inpolygon(xcoord,ycoord,xt,yt);
    n_in = numel(xcoord(in));
%     figure(1)
%     plot(xt, yt,'LineWidth',2) % polygon
%     axis equal
%     hold on
%     plot(xcoord(in),ycoord(in),'r+') % points inside
%     plot(xcoord(~in),ycoord(~in),'bo') % points outside
%     hold off
%     pause(0.2)
%     drawnow
end
end