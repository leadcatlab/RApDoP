function [r,CtCVec,CtBVec,CC,CB] = GetStateGeometry(xc,yc,xt,yt,n,s,isConvex,r_prev,noCons)
CtCVec = zeros(n,n,2);
CC = inf*ones(n);
shape = zeros(s,4);
for i = 1:s
    shape(i,:) = [xt(i) yt(i) xt(i+1) yt(i+1)];
end
for i = 1:n
    for j = 1:n
        if i ~= j
            CC(i,j) = norm([xc(i) - xc(j) yc(i) - yc(j)]);
            if noCons && r_prev > 0 && CC(i,j) > r_prev*4% && sum(ismember([i,j], consIdx)) < 2
                CC(i,j) = inf;
                % fprintf('%d %d\n',i,j)
                continue
            end
            if ~isConvex
                CC_connection = lineSegmentIntersect([xc(i) yc(i) xc(j) yc(j)],shape);
                if sum(CC_connection.intAdjacencyMatrix) > 0% && sum(ismember([i,j], consIdx)) < 2
                    CC(i,j) = inf;
                    continue
                end
            end
            temp = [xc(i) - xc(j)  yc(i) - yc(j)]/abs(CC(i,j));
            CtCVec(i,j,1) = temp(1);
            CtCVec(i,j,2) = temp(2);
        end
    end
end
CtBVec = zeros(n,s,2);
CB = zeros(n,s);
% if isConvex
%     for i = 1:n
%         for j = 1:s
%             if r_prev > 0 && CB(i,j) > r_prev*4
%                 CB(i,j) = inf;
%                     continue
%             end
%             a = [xc(i)-xt(j),yc(i)-yt(j)];
%             c = [xt(j+1)-xt(j),yt(j+1)-yt(j)];
%             CB(i,j) = norm(cross([a 0],[c 0]))/norm(c); 
%             CtBVec(i,j,:) = [-c(2),c(1)]/norm(c);
%         end
%     end
% else
    for i = 1:n
        for j = 1:s
            if r_prev > 0 && CB(i,j) > r_prev*4
                CB(i,j) = inf;
                    continue
            end
            pC = [xc(i), yc(i),0];
            pV1 =[xt(j),yt(j),0];
            pV2 = [xt(j+1), yt(j+1),0];
            switch whichLoc(pV1,pV2,pC)
                case 1
                    PC_connection = lineSegmentIntersect([pC(1:2) pV1(1:2)],shape);
                    tmp = pC-pV1;
                    CB(i,j) = -norm(tmp);
                    if sum(PC_connection.intAdjacencyMatrix) > 2
                        continue
                    end
                    CtBVec(i,j,:) = tmp(1:2)/norm(tmp);
                case 2
%                     perpendicular = pV1+(pV2-pV1)*dot(pC-pV1, pV2-pV1)/norm(pV2-pV1);
%                     PB_connection = lineSegmentIntersect([pC(1:2) perpendicular(1:2)], shape);
                    CB(i,j) = norm(cross(pC-pV1,pV2-pV1))/norm(pV2-pV1);
                    % disp(sum(PB_connection.intAdjacencyMatrix))
%                     if sum(PB_connection.intAdjacencyMatrix) > 2
%                         continue
%                     end
                    c = [xt(j+1)-xt(j),yt(j+1)-yt(j)];
                    CtBVec(i,j,:) = [-c(2),c(1)]/norm(c);
                case 3
                    PC_connection = lineSegmentIntersect([pC(1:2) pV2(1:2)],shape);
                    tmp = pC-pV2;
                    CB(i,j) = -norm(tmp);
                    if sum(PC_connection.intAdjacencyMatrix) > 2
                        continue
                    end
                    CtBVec(i,j,:) = tmp(1:2)/norm(tmp);
                otherwise
                    CB(i,j) = inf;
            end
        end
    end
% end
tmp = abs(reshape([CC/2,CB],1,[]));
r = min(tmp);
end