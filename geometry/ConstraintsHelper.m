function [xc, yc]  = ConstraintsHelper(xt, yt, n, isConvex, cons)
dic = containers.Map('KeyType','int32','ValueType','any');
for i = 1:n
    dic(i) = [];
end
consCount = zeros(1,n);
for i = 1:length(cons)
    con = cons{i};
    dic(con(1)) = [dic(con(1)); con(2) con(3) con(4)];
    dic(con(2)) = [dic(con(2)); con(1) con(3) con(4)];
    consCount(con(1)) = consCount(con(1)) + 1;
    consCount(con(2)) = consCount(con(2)) + 1;
end
[consC, idx] = sort(consCount,'descend');
onPlot = containers.Map('KeyType','int32','ValueType','any');
for i = 1:n
    if consC(i) == 0
        [a, b] = GetPointsInside(1, xt, yt);
        onPlot(idx(i)) = [a,b];
        % fprintf('putting %d on\n', idx(i))
        continue
    end
    [a, b] = GetPointsInside(1, xt, yt);
    curCons = dic(idx(i));
    for j = 1:length(consC(i))
        if ~isKey(onPlot, curCons(j,1))
            disp(curCons(j,1))
            % [pox, poy] = GetPointsInside(100, xt, yt)
            [pox, poy] = circle([a,b], curCons(j,2)+curCons(j,3), floor((curCons(j,2)+curCons(j,3))*2*pi*10));
            [in,~] = inpolygon(pox, poy, xt, yt);
            inx = pox(in);
            iny = pox(in);
            idxr = randi(length(inx),1);
            onPlot(curCons(j,1)) =  [inx(idxr), iny(idxr)];
            fprintf('putting %d on\n', curCons(j,1))
        end
    end
end
xyc = reshape(cell2mat(onPlot.values),2,n)';
xc = xyc(:,1);
yc = xyc(:,2);
end