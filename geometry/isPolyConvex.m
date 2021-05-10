function convex = isPolyConvex(xt,yt,s)
prev = [xt(s)-xt(1), yt(s)-yt(1),0];
convex = ones(1,s+1);
for i = 1:s
    cur = [xt(i+1)-xt(i),yt(i+1)-yt(i),0];
    cp = cross(prev,cur);
    if  cp(3) > 0
        convex(i) = 0;
    end
    prev = -cur;
end
convex(end) = convex(1);
end
