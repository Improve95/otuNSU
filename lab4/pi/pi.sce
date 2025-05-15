//1
s = poly(0, 's');
W=(2/(1+1.31*s)^4)*0.65*(1+1/(6*s))/((2/(1+1.31*s)^4)*(1+1/(6*s))*0.65+1)


b = 0.073571+ 0.4414263 * s;
a = 0.073571 + 0.7809849 * s + 1.7792874 * s^2 + 3.4962997 * s^3 + 3.0534351 * s^4 + s^5;

A = [zeros(1, 4); eye(4, 4)];
ac = [0.073571; 0.7809849; 1.7792874; 3.4962997; 3.0534351];
A = [A, -ac];

B = [0.073571; 0.4414263; 0; 0; 0];
C = [0 0 0 0 1];

//2
sys0 = syslin('c', W);
sysd0 = dscr(sys0, 1);
Ad10 = sysd0.A;
Bd10 = sysd0.B;
Cd10 = sysd0.C;
Ad = Ad10;
Bd = Bd10;
Cd = Cd10;


sys1 = syslin('c', W);
sysd1 = dscr(sys1, 0.1);
Ad11 = sysd1.A;
Bd11 = sysd1.B;
Cd11 = sysd1.C;

sys2 = syslin('c', W);
sysd2 = dscr(sys2, 0.01);
Ad12 = sysd2.A;
Bd12 = sysd2.B;
Cd12 = sysd2.C;
//3
h0 = read("pi0.txt", 1, 101);
h1 = read("pi1.txt", 1, 1001);
h2 = read("pi2.txt", 1, 10001);

//4
function result = calculate_h(Ad, Bd, Cd, count)
	xk = zeros(Ad*Bd);
	h = [];
	for k = 1:count
		h = [h Cd * xk];
		xk = Ad * xk + Bd*1;
    end
    result = h;
endfunction;
h10 = calculate_h(Ad10, Bd10, Cd10, 101);
plot(0:100, h10);
h11 = calculate_h(Ad11, Bd11, Cd11, 1001);
//plot(0:1000, h11);
h12 = calculate_h(Ad12, Bd12, Cd12, 10001);
//plot(0:10000, h12);
//5
function result = calculate_error(realH, approxH)
	errors = (realH - approxH) .^ 2;
	errors_sum = sum(errors);
	result = errors_sum / length(realH);
endfunction;
disp(calculate_error(h0, h10));
disp(calculate_error(h1, h11));
disp(calculate_error(h2, h12));