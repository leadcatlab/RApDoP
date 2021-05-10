function loc = whichLoc(pv1,pv2,c)
v1 = pv2-pv1;
v2=c-pv1;
v3=c-pv2;
v4 = -v1;
if dot(v1,v2) > 0
    if dot(v3,v4) > 0
        tmp = cross(v1,v2);
        if tmp(3) > 0
            loc = 2;
        else
            loc = 4;
        end
    else
        loc = 3;
    end
else
    loc = 1;
end
end