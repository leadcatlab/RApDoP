function move = updateCircle(Csum, n,r,stp)
    move = zeros(n,2);
    Csum_max = max(vecnorm(Csum,2,2));

    for i = 1:n
        if norm(Csum(i,:)) == 0
            continue
        end
        move(i,:) = Csum(i,:)'/Csum_max*(stp*r);%*((itr-idx)/itr)^0.5);
    end
end
