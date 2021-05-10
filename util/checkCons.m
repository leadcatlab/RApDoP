function confirm = checkCons(cons, xc, yc)
confirm = 1;
if ~isempty(cons)
for i = 1:length(cons(:,1))
    con = cons(i,:);
    dis = norm([xc(con(1)) - xc(con(2)), yc(con(1)) - yc(con(2))]);
%     fprintf('%5f < %5f < %5f\n',con(3),dis, con(4))
    confirm = confirm && dis >= con(3) && dis <= con(4);
%     if ~ (dis > con(3) && dis < con(4))
%         fprintf('Conflict between %d C: (%d,%d) and %d C: (%d,%d)\n',con(1), xc(con(1)), yc(con(1)),con(2),xc(con(2)),yc(con(2)))
%     end
end
end
end