function nUpdateWaitbar(maxr)
    global p N h r_prev
    if r_prev < maxr
        r_prev = maxr;
    end
    waitbar(min(p/N, 1.0),h,sprintf('trails: %d/%d, current r_{max} = %5f',p, N, r_prev));
    p = p + 1;
end