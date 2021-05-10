function Csum = GetRepulsionForce(n,CtCVec,CtBVec,CC,CB,r,rep)
thr = r*rep.threshod;
muB = rep.muB;
muC = rep.muC;
muP = rep.muP;
s = rep.s;
Csum = zeros(n,2);
CtC = zeros(n,n,2);
CtB = zeros(n,s,2);
for i = 1:n
    for j = 1:n
        if CC(i,j) ~= inf && CC(i,j) < 4*r
            CtC(i,j,:) = muC/(max(CC(i,j)-2*r, 0.001*r))^2*CtCVec(i,j,:);
            Csum(i,:) = Csum(i,:) + reshape(CtC(i,j,:),[1,2]);
        end
    end
    for j = 1:s
        if CB(i,j) > 0 && CB(i,j) < 4*r
            CtB(i,j,:) = muB/(max(CB(i,j)-1*r, thr))^2*CtBVec(i,j,:);
            Csum(i,:) = Csum(i,:) + reshape(CtB(i,j,:),[1,2]);
        elseif CB(i,j) < 0 && -CB(i,j) < 4*r
            CtB(i,j,:) = muP/(max(-CB(i,j)-1*r, thr))^2*CtBVec(i,j,:);
            Csum(i,:) = Csum(i,:) + reshape(CtB(i,j,:),[1,2]);
        end
    end
end
% for k = 1:length(cons)
%     con = cons{k};
%     i = con(1);
%     j = con(2);
%     CtC(i,j,:) = CtC(i,j,:) + muC/(max(CC(i,j)-2*r, 0.001*r))^2*CtCVec(i,j,:);
%     Csum(i,:) = Csum(i,:) + reshape(CtC(i,j,:),[1,2]);
% end
end