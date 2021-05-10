function consDic = consDicHelper(cons, n)
consDic = containers.Map('KeyType', 'int32', 'ValueType', 'any');
if ~isempty(cons)
    for i = unique(reshape(cons(:,1:2).',1,[]))
        consDic(i) = [];
        if i > n
            error('Constraints on nonexistent circles!')
        end
    end
    for i = 1:length(cons(:,1))
        con = cons(i,:);
        consDic(con(1)) = [consDic(con(1)); con(2) con(3) con(4)];
        consDic(con(2)) = [consDic(con(2)); con(1) con(3) con(4)];
    end
end
end