s = poly(0, 's');
W=(2/(1+1.31*s)^4)*0.65*(1+1/(6*s))/((2/(1+1.31*s)^4)*(1+1/(6*s))*0.65+1)

A = [zeros(1, 4); eye(4, 4)];
ac = [0.073571; 0.7809849; 1.7792874; 3.4962997; 3.0534351];
A = [A, -ac];

disp("Матрица A: ");
disp(A);

H = lyap(A, -eye(A), 'c');
disp("H");
disp(H);
disp("Собственные числа H");
disp(spec(H));
disp("К устойчивости");
k = max(spec(H));
disp(k);