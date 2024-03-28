function out = popmat(theta)

% Build the population model for Wandering albatrosses - To estimate LRS and LEX

% First stage is fledgling, so PB1 = Fledged chicks of age 0

Max_age = 55;
max_age_class = 30; 

% Age first reproduction
age_first = 6; 
age_last = 16;

% offspring production: 
rho = 0.5;

% There are 6 states:
% State 1 = Pre-breeders (PB1-PB16); Age = 0-15 (16 stages)
n_PB = length(1:16);
% Stage 2 = Successful breeders (SB7 - SB31); Age = 6-54, but group them from age 30+ (25 stages)
n_SB = length(age_first:max_age_class);
% Stage 3 = Failed breeders (FB7 - FB31); Age = 6-54, but group them from 30+ (25 stages)
n_FB = length(age_first:max_age_class);
% stage 4 = Post-successful breeders (PSB7 - PSB31); Age = 6-54, but group them from 30+ (25 stages); can only be reached from SB age 6 onward
n_PSB = length(age_first:max_age_class);
% stage 5 = Post-failed breeders (PFB7 - PFB31); Age = 6-54, but group them from 30+ (25 stages); can only be reached from FB age 6 onward
n_PFB = length(age_first:max_age_class);
% stage 6 = Non-breeders (NB7 - NB31); Age = 6-54, but group them from 30+ (25 stages); can only be reached from PSB and PFB age 7 onward
n_NB = length(age_first:max_age_class);

% Pop matrix dimensions
s = n_PB + n_SB + n_FB + n_PSB + n_PFB + n_NB;

% Initiate the pop matrix A
A = zeros(s, s);
U = A; F = A;

% Parameters

%%%%%%%%%%%%%%%%%%%%%%%%
% Survival, sigma (phi in the JAGS model): 

% Pre-breeders
%   theta 1: survival probability PB1; Probability that a fledgling survives until age 1
%   theta 2: survival probability PB2 
%   theta 3: survival probability PB3
%   theta 4: survival probability PB4
%   theta 5: survival probability PB5
%   theta 6: survival probability PB6; survival probability of PB6 (age 5 years-old)
%   theta 7: survival probability PB7
%   theta 8: survival probability PB8
%   theta 9: survival probability PB9
%   theta 10: survival probability PB10
%   theta 11: survival probability PB11
%   theta 12: survival probability PB12
%   theta 13: survival probability PB13
%   theta 14: survival probability PB14
%   theta 15: survival probability PB15
%   theta 16: survival probability PB16; survival probability of PB16 (age = 15)

% Successful breeders
%  theta 17: survival probability SB7; Probability that a SB age 6 survives until age 7
%  theta 18: survival probability SB8
%  theta 19: survival probability SB9
%  theta 20: survival probability SB10
%  theta 21: survival probability SB11
%  theta 22: survival probability SB12
%  theta 23: survival probability SB13
%  theta 24: survival probability SB14
%  theta 25: survival probability SB15
%  theta 26: survival probability SB16
%  theta 27: survival probability SB17
%  theta 28: survival probability SB18
%  theta 29: survival probability SB19
%  theta 30: survival probability SB20
%  theta 31: survival probability SB21
%  theta 32: survival probability SB22
%  theta 33: survival probability SB23
%  theta 34: survival probability SB24
%  theta 35: survival probability SB25
%  theta 36: survival probability SB26
%  theta 37: survival probability SB27
%  theta 38: survival probability SB28
%  theta 39: survival probability SB29
%  theta 40: survival probability SB30
%  theta 41: survival probability SB31; survival probability of SB 30 years old and older

% Failed breeders
%  theta 42: survival probability FB7; Probability that a FB age 6 survives until age 7
%  theta 43: survival probability FB8
%  theta 44: survival probability FB9
%  theta 45: survival probability FB10
%  theta 46: survival probability FB11
%  theta 47: survival probability FB12
%  theta 48: survival probability FB13
%  theta 49: survival probability FB14
%  theta 50: survival probability FB15
%  theta 51: survival probability FB16
%  theta 52: survival probability FB17
%  theta 53: survival probability FB18
%  theta 54: survival probability FB19
%  theta 55: survival probability FB20
%  theta 56: survival probability FB21
%  theta 57: survival probability FB22
%  theta 58: survival probability FB23
%  theta 59: survival probability FB24
%  theta 60: survival probability FB25
%  theta 61: survival probability FB26
%  theta 62: survival probability FB27
%  theta 63: survival probability FB28
%  theta 64: survival probability FB29
%  theta 65: survival probability FB30
%  theta 66: survival probability FB31; survival probability of FB 30 years old and older


% Post-Successful breeders
%  theta 67: survival probability PSB7; Probability that a PSB age 6 survives until age 7
%  theta 68: survival probability PSB8
%  theta 69: survival probability PSB9
%  theta 70: survival probability PSB10
%  theta 71: survival probability PSB11
%  theta 72: survival probability PSB12
%  theta 73: survival probability PSB13
%  theta 74: survival probability PSB14
%  theta 75: survival probability PSB15
%  theta 76: survival probability PSB16
%  theta 77: survival probability PSB17
%  theta 78: survival probability PSB18
%  theta 79: survival probability PSB19
%  theta 80: survival probability PSB20
%  theta 81: survival probability PSB21
%  theta 82: survival probability PSB22
%  theta 83: survival probability PSB23
%  theta 84: survival probability PSB24
%  theta 85: survival probability PSB25
%  theta 86: survival probability PSB26
%  theta 87: survival probability PSB27
%  theta 88: survival probability PSB28
%  theta 89: survival probability PSB29
%  theta 90: survival probability PSB30
%  theta 91: survival probability PSB31; survival probability of PSB 30 years old and older


% Post-Failed breeders
%  theta 92: survival probability PFB7; Probability that a PFB age 6 survives until age 7
%  theta 93: survival probability PFB8
%  theta 94: survival probability PFB9
%  theta 95: survival probability PFB10
%  theta 96: survival probability PFB11
%  theta 97: survival probability PFB12
%  theta 98: survival probability PFB13
%  theta 99: survival probability PFB14
%  theta 100: survival probability PFB15
%  theta 101: survival probability PFB16
%  theta 102: survival probability PFB17
%  theta 103: survival probability PFB18
%  theta 104: survival probability PFB19
%  theta 105: survival probability PFB20
%  theta 106: survival probability PFB21
%  theta 107: survival probability PFB22
%  theta 108: survival probability PFB23
%  theta 109: survival probability PFB24
%  theta 110: survival probability PFB25
%  theta 111: survival probability PFB26
%  theta 112: survival probability PFB27
%  theta 113: survival probability PFB28
%  theta 114: survival probability PFB29
%  theta 115: survival probability PFB30
%  theta 116: survival probability PFB31; survival probability of PFB 30 years old and older

% Non-breeders
%  theta 117: survival probability NB7; Probability that a NB age 6 survives until age 7
%  theta 118: survival probability NB8
%  theta 119: survival probability NB9
%  theta 120: survival probability NB10
%  theta 121: survival probability NB11
%  theta 122: survival probability NB12
%  theta 123: survival probability NB13
%  theta 124: survival probability NB14
%  theta 125: survival probability NB15
%  theta 126: survival probability NB16
%  theta 127: survival probability NB17
%  theta 128: survival probability NB18
%  theta 129: survival probability NB19
%  theta 130: survival probability NB20
%  theta 131: survival probability NB21
%  theta 132: survival probability NB22
%  theta 133: survival probability NB23
%  theta 134: survival probability NB24
%  theta 135: survival probability NB25
%  theta 136: survival probability NB26
%  theta 137: survival probability NB27
%  theta 138: survival probability NB28
%  theta 139: survival probability NB29
%  theta 140: survival probability NB30
%  theta 141: survival probability NB31; survival probability of NB 30 years old and older


%%%%%%%%%%%%%%%%%%%%%%%%
% Breeding probability, beta (rho in the JAGS model): 
% Pre-breeders
%  theta 142: breeding probability of PB1; probability that a PB1 (age 0) breeds from year t to t+1 
%  theta 143: breeding probability of PB2
%  theta 144: breeding probability of PB3
%  theta 145: breeding probability of PB4
%  theta 146: breeding probability of PB5
%  theta 147: breeding probability of PB6; probability that a PB6 (age 5) breeds from year t to t+1 
%  theta 148: breeding probability of PB7
%  theta 149: breeding probability of PB8
%  theta 150: breeding probability of PB9
%  theta 151: breeding probability of PB10
%  theta 152: breeding probability of PB11
%  theta 153: breeding probability of PB12
%  theta 154: breeding probability of PB13
%  theta 155: breeding probability of PB14
%  theta 156: breeding probability of PB15
%  theta 157: breeding probability of PB16; probability that a PB16 (age 15) breeds from year t to t+1 

% Successful breeders
%  theta 158: breeding probability of SB7; probability that a SB6 (age 6) breeds from year t to t+1 
%  theta 159: breeding probability of SB8
%  theta 160: breeding probability of SB9
%  theta 161: breeding probability of SB10
%  theta 162: breeding probability of SB11
%  theta 163: breeding probability of SB12
%  theta 164: breeding probability of SB13
%  theta 165: breeding probability of SB14
%  theta 166: breeding probability of SB15
%  theta 167: breeding probability of SB16
%  theta 168: breeding probability of SB17
%  theta 169: breeding probability of SB18
%  theta 170: breeding probability of SB19
%  theta 171: breeding probability of SB20
%  theta 172: breeding probability of SB21
%  theta 173: breeding probability of SB22
%  theta 174: breeding probability of SB23
%  theta 175: breeding probability of SB24
%  theta 176: breeding probability of SB25
%  theta 177: breeding probability of SB26
%  theta 178: breeding probability of SB27
%  theta 179: breeding probability of SB28
%  theta 180: breeding probability of SB29
%  theta 181: breeding probability of SB30
%  theta 182: breeding probability of SB31; probability that a SB31 (age 30+) breeds from year t to t+1 


% Failed breeders
%  theta 183: breeding probability of FB7; probability that a FB6 (age 6) breeds from year t to t+1 
%  theta 184: breeding probability of FB8;
%  theta 185: breeding probability of FB9;
%  theta 186: breeding probability of FB10;
%  theta 187: breeding probability of FB11;
%  theta 188: breeding probability of FB12;
%  theta 189: breeding probability of FB13;
%  theta 190: breeding probability of FB14;
%  theta 191: breeding probability of FB15;
%  theta 192: breeding probability of FB16;
%  theta 193: breeding probability of FB17;
%  theta 194: breeding probability of FB18;
%  theta 195: breeding probability of FB19;
%  theta 196: breeding probability of FB20;
%  theta 197: breeding probability of FB21;
%  theta 198: breeding probability of FB22;
%  theta 199: breeding probability of FB23;
%  theta 200: breeding probability of FB24;
%  theta 201: breeding probability of FB25;
%  theta 202: breeding probability of FB26;
%  theta 203: breeding probability of FB27;
%  theta 204: breeding probability of FB28;
%  theta 205: breeding probability of FB29;
%  theta 206: breeding probability of FB30;
%  theta 207: breeding probability of FB31; probability that a FB31 (age 30+) breeds from year t to t+1 

% Post-successful breeders
%  theta 208: breeding probability of PSB7; probability that a PSB6 (age 6) breeds from year t to t+1 
%  theta 209: breeding probability of PSB8
%  theta 210: breeding probability of PSB9
%  theta 211: breeding probability of PSB10
%  theta 212: breeding probability of PSB11
%  theta 213: breeding probability of PSB12
%  theta 214: breeding probability of PSB13
%  theta 215: breeding probability of PSB14
%  theta 216: breeding probability of PSB15
%  theta 217: breeding probability of PSB16
%  theta 218: breeding probability of PSB17
%  theta 219: breeding probability of PSB18
%  theta 220: breeding probability of PSB19
%  theta 221: breeding probability of PSB20
%  theta 222: breeding probability of PSB21
%  theta 223: breeding probability of PSB22
%  theta 224: breeding probability of PSB23
%  theta 225: breeding probability of PSB24
%  theta 226: breeding probability of PSB25
%  theta 227: breeding probability of PSB26
%  theta 228: breeding probability of PSB27
%  theta 229: breeding probability of PSB28
%  theta 230: breeding probability of PSB29
%  theta 231: breeding probability of PSB30
%  theta 232: breeding probability of PSB31; probability that a PSB31 (age 30+) breeds from year t to t+1 


% Post-failed breeders
%  theta 233: breeding probability of PFB7; probability that a PFB6 (age 6) breeds from year t to t+1 
%  theta 234: breeding probability of PFB8
%  theta 235: breeding probability of PFB9
%  theta 236: breeding probability of PFB10
%  theta 237: breeding probability of PFB11
%  theta 238: breeding probability of PFB12
%  theta 239: breeding probability of PFB13
%  theta 240: breeding probability of PFB14
%  theta 241: breeding probability of PFB15
%  theta 242: breeding probability of PFB16
%  theta 243: breeding probability of PFB17
%  theta 244: breeding probability of PFB18
%  theta 245: breeding probability of PFB19
%  theta 246: breeding probability of PFB20
%  theta 247: breeding probability of PFB21
%  theta 248: breeding probability of PFB22
%  theta 249: breeding probability of PFB23
%  theta 250: breeding probability of PFB24
%  theta 251: breeding probability of PFB25
%  theta 252: breeding probability of PFB26
%  theta 253: breeding probability of PFB27
%  theta 254: breeding probability of PFB28
%  theta 255: breeding probability of PFB29
%  theta 256: breeding probability of PFB30
%  theta 257: breeding probability of PFB31; probability that a PFB31 (age 30+) breeds from year t to t+1 


% Non-breeders
%  theta 258: breeding probability of NB7; probability that a NB6 (age 6) breeds from year t to t+1 
%  theta 259: breeding probability of NB8
%  theta 260: breeding probability of NB9
%  theta 261: breeding probability of NB10
%  theta 262: breeding probability of NB11
%  theta 263: breeding probability of NB12
%  theta 264: breeding probability of NB13
%  theta 265: breeding probability of NB14
%  theta 266: breeding probability of NB15
%  theta 267: breeding probability of NB16
%  theta 268: breeding probability of NB17
%  theta 269: breeding probability of NB18
%  theta 270: breeding probability of NB19
%  theta 271: breeding probability of NB20
%  theta 272: breeding probability of NB21
%  theta 273: breeding probability of NB22
%  theta 274: breeding probability of NB23
%  theta 275: breeding probability of NB24
%  theta 276: breeding probability of NB25
%  theta 277: breeding probability of NB26
%  theta 278: breeding probability of NB27
%  theta 279: breeding probability of NB28
%  theta 280: breeding probability of NB29
%  theta 281: breeding probability of NB30
%  theta 282: breeding probability of NB31; probability that a NB31 (age 30+) breeds from year t to t+1 


%%%%%%%%%%%%%%%%%%%%%%%%
% Breeding success, gamma (phi in the JAGS model): 
% Pre-breeders
% theta 283: breeding success of PB1 (age 0); given having breed from age 0 to 1, probability that PB1 raises successfully a chick.
% theta 284: breeding success of PB2
% theta 285: breeding success of PB3
% theta 286: breeding success of PB4
% theta 287: breeding success of PB5
% theta 288: breeding success of PB6
% theta 289: breeding success of PB7
% theta 290: breeding success of PB8
% theta 291: breeding success of PB9
% theta 292: breeding success of PB10
% theta 293: breeding success of PB11
% theta 294: breeding success of PB12
% theta 295: breeding success of PB13
% theta 296: breeding success of PB14
% theta 297: breeding success of PB15
% theta 298: breeding success of PB16

% Successful breeders
% theta 299: breeding success of SB7 (age 6); given having breed from age 6 to 7, probability that SB6 raises successfully a chick.
% theta 300: breeding success of SB8
% theta 301: breeding success of SB9
% theta 302: breeding success of SB10
% theta 303: breeding success of SB11
% theta 304: breeding success of SB12
% theta 305: breeding success of SB13
% theta 306: breeding success of SB14
% theta 307: breeding success of SB15
% theta 308: breeding success of SB16
% theta 309: breeding success of SB17
% theta 310: breeding success of SB18
% theta 311: breeding success of SB19
% theta 312: breeding success of SB20
% theta 313: breeding success of SB21
% theta 314: breeding success of SB22
% theta 315: breeding success of SB23
% theta 316: breeding success of SB24
% theta 317: breeding success of SB25
% theta 318: breeding success of SB26
% theta 319: breeding success of SB27
% theta 320: breeding success of SB28
% theta 321: breeding success of SB29
% theta 322: breeding success of SB30
% theta 323: breeding success of SB31; probability that a SB31 (age 30+) breeds successfully 

% Failed breeders
% theta 324: breeding success of FB7 (age 6); given having breed from age 6 to 7, probability that FB6 raises successfully a chick.
% theta 325: breeding success of FB8 
% theta 326: breeding success of FB9 
% theta 327: breeding success of FB10 
% theta 328: breeding success of FB11 
% theta 329: breeding success of FB12 
% theta 330: breeding success of FB13
% theta 331: breeding success of FB14 
% theta 332: breeding success of FB15
% theta 333: breeding success of FB16
% theta 334: breeding success of FB17
% theta 335: breeding success of FB18
% theta 336: breeding success of FB19
% theta 337: breeding success of FB20
% theta 338: breeding success of FB21
% theta 339: breeding success of FB22
% theta 340: breeding success of FB23
% theta 341: breeding success of FB24
% theta 342: breeding success of FB25
% theta 343: breeding success of FB26
% theta 344: breeding success of FB27
% theta 345: breeding success of FB28
% theta 346: breeding success of FB29
% theta 347: breeding success of FB30
% theta 348: breeding success of FB31; probability that a FB31 (age 30+) breeds successfully 


% Post successful breeders
% theta 349: breeding success of PSB7 (age 6); given having breed from age 6 to 7, probability that PSB6 raises successfully a chick.
% theta 350: breeding success of PSB8 
% theta 351: breeding success of PSB9 
% theta 352: breeding success of PSB10 
% theta 353: breeding success of PSB11 
% theta 354: breeding success of PSB12
% theta 355: breeding success of PSB13
% theta 356: breeding success of PSB14
% theta 357: breeding success of PSB15
% theta 358: breeding success of PSB16
% theta 359: breeding success of PSB17
% theta 360: breeding success of PSB18
% theta 361: breeding success of PSB19
% theta 362: breeding success of PSB20 
% theta 363: breeding success of PSB21 
% theta 364: breeding success of PSB22
% theta 365: breeding success of PSB23
% theta 366: breeding success of PSB24
% theta 367: breeding success of PSB25
% theta 368: breeding success of PSB26
% theta 369: breeding success of PSB27
% theta 370: breeding success of PSB28
% theta 371: breeding success of PSB29
% theta 372: breeding success of PSB30
% theta 373: breeding success of PSB31; probability that a PSB31 (age 30+) breeds successfully 


% Post failed breeders
% theta 374: breeding success of PFB7 (age 6); given having breed from age 6 to 7, probability that PFB6 raises successfully a chick.
% theta 375: breeding success of PFB8
% theta 376: breeding success of PFB9
% theta 377: breeding success of PFB10
% theta 378: breeding success of PFB11
% theta 379: breeding success of PFB12
% theta 380: breeding success of PFB13
% theta 381: breeding success of PFB14
% theta 382: breeding success of PFB15
% theta 383: breeding success of PFB16
% theta 384: breeding success of PFB17
% theta 385: breeding success of PFB18
% theta 386: breeding success of PFB19
% theta 387: breeding success of PFB20
% theta 388: breeding success of PFB21
% theta 389: breeding success of PFB22
% theta 390: breeding success of PFB23
% theta 391: breeding success of PFB24
% theta 392: breeding success of PFB25
% theta 393: breeding success of PFB26
% theta 394: breeding success of PFB27
% theta 395: breeding success of PFB28
% theta 396: breeding success of PFB29
% theta 397: breeding success of PFB30
% theta 398: breeding success of PFB31; probability that a PFB31 (age 30+) breeds successfully 


% Non breeders
% theta 399: breeding success of NB7 (age 6); given having breed from age 6 to 7, probability that NB6 raises successfully a chick.
% theta 400: breeding success of NB8
% theta 401: breeding success of NB9
% theta 402: breeding success of NB10
% theta 403: breeding success of NB11
% theta 404: breeding success of NB12
% theta 405: breeding success of NB13
% theta 406: breeding success of NB14
% theta 407: breeding success of NB15
% theta 408: breeding success of NB16
% theta 409: breeding success of NB17
% theta 410: breeding success of NB18
% theta 411: breeding success of NB19
% theta 412: breeding success of NB20
% theta 413: breeding success of NB21
% theta 414: breeding success of NB22
% theta 415: breeding success of NB23
% theta 416: breeding success of NB24
% theta 417: breeding success of NB25
% theta 418: breeding success of NB26
% theta 419: breeding success of NB27
% theta 420: breeding success of NB28
% theta 421: breeding success of NB29
% theta 422: breeding success of NB30
% theta 423: breeding success of NB31; probability that a NB31 (age 30+) breeds successfully 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% TRANSITIONS
%%% Pre-breeders, PB, transitions 
A(2,1) = theta(1); % survival PB1 to PB2
A(3,2) = theta(2); % survival of PB2 to PB3
A(4,3) = theta(3); % survival of PB3 to PB4
A(5,4) = theta(4); % survival of PB4 to PB5
A(6,5) = theta(5); % survival of PB5 to PB6

%% Upon age 5, PB can transit to SB or FB or remain in PB
% Remaining a prebreeder, PB to PB
A(7,6) = theta(6)*(1-theta(147)); % survival of PB6 to PB7 * (1- probability of breeding as PB6 at age 5)
A(8,7) = theta(7)*(1-theta(148)); % survival of PB7 to PB8 * (1- probability of breeding at age 6)
A(9,8) = theta(8)*(1-theta(149)); % survival of PB8 to PB9 * (1- probability of breeding at age 7)
A(10,9) = theta(9)*(1-theta(150)); % survival of PB9 to PB10 * (1- probability of breeding at age 8)
A(11,10) = theta(10)*(1-theta(151)); % survival of PB10 to PB11 * (1- probability of breeding at age 9)
A(12,11) = theta(11)*(1-theta(152)); % survival of PB11 to PB12 * (1- probability of breeding at age 10)
A(13, 12) = theta(12)*(1-theta(153)); % survival of PB12 to PB13 * (1- probability of breeding at age 11)
A(14,13) = theta(13)*(1-theta(154)); % survival of PB13 to PB14 * (1- probability of breeding at age 12)
A(15, 14) = theta(14)*(1-theta(155)); % survival of PB14 to PB15 * (1- probability of breeding at age 13)
A(16,15) = theta(15)*(1-theta(156)); % survival of PB15 to PB16 * (1- probability of breeding at age 14)
A(16,16) = theta(16)*(1-theta(157)); % survival of PB16 to PB16 * (1- probability of breeding at age 15)
% this last one could be removed

% Transit to successful breeder, PB to SB
A(17,6) = theta(6)*theta(147)*theta(288); % survival of PB6 * breeding probability of PB6 * Breeding success of PB6
A(18,7) = theta(7)*theta(148)*theta(289); % survival of PB7 * breeding probability of PB7 * Breeding success of PB7
A(19,8) = theta(8)*theta(149)*theta(290); % survival of PB8 * breeding probability of PB8 * Breeding success of PB8
A(20,9) = theta(9)*theta(150)*theta(291); % survival of PB9 * breeding probability of PB9 * Breeding success of PB9
A(21,10) = theta(10)*theta(151)*theta(292); % survival of PB10 * breeding probability of PB10 * Breeding success of PB10
A(22,11) = theta(11)*theta(152)*theta(293); % survival of PB11 * breeding probability of PB11 * Breeding success of PB11
A(23,12) = theta(12)*theta(153)*theta(294); % survival of PB12 * breeding probability of PB12 * Breeding success of PB12
A(24,13) = theta(13)*theta(154)*theta(295); % survival of PB13 * breeding probability of PB13 * Breeding success of PB13
A(25,14) = theta(14)*theta(155)*theta(296); % survival of PB14 * breeding probability of PB14 * Breeding success of PB14
A(26,15) = theta(15)*theta(156)*theta(297); % survival of PB15 * breeding probability of PB15 * Breeding success of PB15
A(27,16) = theta(16)*theta(157)*theta(298); % survival of PB16 * breeding probability of PB16 * Breeding success of PB16
A(28,16) = theta(16)*theta(157)*theta(298); % survival of PB16 * breeding probability of PB16 * Breeding success of PB16
A(29,16) = theta(16)*theta(157)*theta(298); % survival of PB16 * breeding probability of PB16 * Breeding success of PB16
A(30,16) = theta(16)*theta(157)*theta(298); % survival of PB16 * breeding probability of PB16 * Breeding success of PB16
A(31,16) = theta(16)*theta(157)*theta(298); % survival of PB16 * breeding probability of PB16 * Breeding success of PB16
A(32,16) = theta(16)*theta(157)*theta(298); % survival of PB16 * breeding probability of PB16 * Breeding success of PB16
A(33,16) = theta(16)*theta(157)*theta(298); % survival of PB16 * breeding probability of PB16 * Breeding success of PB16
A(34,16) = theta(16)*theta(157)*theta(298); % survival of PB16 * breeding probability of PB16 * Breeding success of PB16
A(35,16) = theta(16)*theta(157)*theta(298); % survival of PB16 * breeding probability of PB16 * Breeding success of PB16
A(36,16) = theta(16)*theta(157)*theta(298); % survival of PB16 * breeding probability of PB16 * Breeding success of PB16
A(37,16) = theta(16)*theta(157)*theta(298); % survival of PB16 * breeding probability of PB16 * Breeding success of PB16
A(38,16) = theta(16)*theta(157)*theta(298); % survival of PB16 * breeding probability of PB16 * Breeding success of PB16
A(39,16) = theta(16)*theta(157)*theta(298); % survival of PB16 * breeding probability of PB16 * Breeding success of PB16
A(40,16) = theta(16)*theta(157)*theta(298); % survival of PB16 * breeding probability of PB16 * Breeding success of PB16
A(41,16) = theta(16)*theta(157)*theta(298); % survival of PB16 * breeding probability of PB16 * Breeding success of PB16


% Transit to failed breeder, PB to FB
A(42,6) = theta(6)*theta(147)*(1-theta(288)); % survival of PB6 * breeding probability of PB6 * 1- Breeding success of PB6
A(43,7) = theta(7)*theta(148)*(1-theta(289)); % survival of PB7 * breeding probability of PB7 * 1- Breeding success of PB7
A(44,8) = theta(8)*theta(149)*(1-theta(290)); % survival of PB8 * breeding probability of PB8 * 1- Breeding success of PB8
A(45,9) = theta(9)*theta(150)*(1-theta(291)); % survival of PB9 * breeding probability of PB9 * 1- Breeding success of PB9
A(46,10) = theta(10)*theta(151)*(1-theta(292)); % survival of PB10 * breeding probability of PB10 * 1- Breeding success of PB10
A(47,11) = theta(11)*theta(152)*(1-theta(293)); % survival of PB11 * breeding probability of PB11 * 1- Breeding success of PB11
A(48,12) = theta(12)*theta(153)*(1-theta(294)); % survival of PB12 * breeding probability of PB12 * 1- Breeding success of PB12
A(49,13) = theta(13)*theta(154)*(1-theta(295)); % survival of PB13 * breeding probability of PB13 * 1- Breeding success of PB13
A(50,14) = theta(14)*theta(155)*(1-theta(296)); % survival of PB14 * breeding probability of PB14 * 1- Breeding success of PB14
A(51,15) = theta(15)*theta(156)*(1-theta(297)); % survival of PB15 * breeding probability of PB15 * 1- Breeding success of PB15
A(52,16) = theta(16)*theta(157)*(1-theta(298)); % survival of PB16 * breeding probability of PB16 * 1- Breeding success of PB16
A(53,16) = theta(16)*theta(157)*(1-theta(298)); % survival of PB16 * breeding probability of PB16 * 1- Breeding success of PB16
A(54,16) = theta(16)*theta(157)*(1-theta(298)); % survival of PB16 * breeding probability of PB16 * 1- Breeding success of PB16
A(55,16) = theta(16)*theta(157)*(1-theta(298)); % survival of PB16 * breeding probability of PB16 * 1- Breeding success of PB16
A(56,16) = theta(16)*theta(157)*(1-theta(298)); % survival of PB16 * breeding probability of PB16 * 1- Breeding success of PB16
A(57,16) = theta(16)*theta(157)*(1-theta(298)); % survival of PB16 * breeding probability of PB16 * 1- Breeding success of PB16
A(58,16) = theta(16)*theta(157)*(1-theta(298)); % survival of PB16 * breeding probability of PB16 * 1- Breeding success of PB16
A(59,16) = theta(16)*theta(157)*(1-theta(298)); % survival of PB16 * breeding probability of PB16 * 1- Breeding success of PB16
A(60,16) = theta(16)*theta(157)*(1-theta(298)); % survival of PB16 * breeding probability of PB16 * 1- Breeding success of PB16
A(61,16) = theta(16)*theta(157)*(1-theta(298)); % survival of PB16 * breeding probability of PB16 * 1- Breeding success of PB16
A(62,16) = theta(16)*theta(157)*(1-theta(298)); % survival of PB16 * breeding probability of PB16 * 1- Breeding success of PB16
A(63,16) = theta(16)*theta(157)*(1-theta(298)); % survival of PB16 * breeding probability of PB16 * 1- Breeding success of PB16
A(64,16) = theta(16)*theta(157)*(1-theta(298)); % survival of PB16 * breeding probability of PB16 * 1- Breeding success of PB16
A(65,16) = theta(16)*theta(157)*(1-theta(298)); % survival of PB16 * breeding probability of PB16 * 1- Breeding success of PB16
A(66,16) = theta(16)*theta(157)*(1-theta(298)); % survival of PB16 * breeding probability of PB16 * 1- Breeding success of PB16

%% Successful breeders, SB, transitions
% Remaining successful breeder, SB to SB
A(18,17) = theta(17)*theta(158)*theta(299); % survival of SB7 * breeding probability of SB7 * breeding success of SB7
A(19,18) = theta(18)*theta(159)*theta(300); % survival of SB8 * breeding probability of SB8 * breeding success of SB8
A(20,19) = theta(19)*theta(160)*theta(301); % survival of SB9 * breeding probability of SB9 * breeding success of SB9
A(21,20) = theta(20)*theta(161)*theta(302); % survival of SB10 * breeding probability of SB10 * breeding success of SB10
A(22,21) = theta(21)*theta(162)*theta(303); % survival of SB11 * breeding probability of SB11 * breeding success of SB11
A(23,22) = theta(22)*theta(163)*theta(304); % survival of SB12 * breeding probability of SB12 * breeding success of SB12
A(24,23) = theta(23)*theta(164)*theta(305); % survival of SB13 * breeding probability of SB13 * breeding success of SB13
A(25,24) = theta(24)*theta(165)*theta(306); % survival of SB14 * breeding probability of SB14 * breeding success of SB14
A(26,25) = theta(25)*theta(166)*theta(307); % survival of SB15 * breeding probability of SB15 * breeding success of SB15
A(27,26) = theta(26)*theta(167)*theta(308); % survival of SB16 * breeding probability of SB16 * breeding success of SB16
A(28,27) = theta(27)*theta(168)*theta(309); % survival of SB17 * breeding probability of SB17 * breeding success of SB17
A(29,28) = theta(28)*theta(169)*theta(310); % survival of SB18 * breeding probability of SB18 * breeding success of SB18
A(30,29) = theta(29)*theta(170)*theta(311); % survival of SB19 * breeding probability of SB19 * breeding success of SB19
A(31,30) = theta(30)*theta(171)*theta(312); % survival of SB20 * breeding probability of SB20 * breeding success of SB20
A(32,31) = theta(31)*theta(172)*theta(313); % survival of SB21 * breeding probability of SB21 * breeding success of SB21
A(33,32) = theta(32)*theta(173)*theta(314); % survival of SB22 * breeding probability of SB22 * breeding success of SB22
A(34,33) = theta(33)*theta(174)*theta(315); % survival of SB23 * breeding probability of SB23 * breeding success of SB23
A(35,34) = theta(34)*theta(175)*theta(316); % survival of SB24 * breeding probability of SB24 * breeding success of SB24
A(36,35) = theta(35)*theta(176)*theta(317); % survival of SB25 * breeding probability of SB25 * breeding success of SB25
A(37,36) = theta(36)*theta(177)*theta(318); % survival of SB26 * breeding probability of SB26 * breeding success of SB26
A(38,37) = theta(37)*theta(178)*theta(319); % survival of SB27 * breeding probability of SB27 * breeding success of SB27
A(39,38) = theta(38)*theta(179)*theta(320); % survival of SB28 * breeding probability of SB28 * breeding success of SB28
A(40,39) = theta(39)*theta(180)*theta(321); % survival of SB29 * breeding probability of SB29 * breeding success of SB29
A(41,40) = theta(40)*theta(181)*theta(322); % survival of SB30 * breeding probability of SB30 * breeding success of SB30
A(41,41) = theta(41)*theta(182)*theta(323); % survival of SB31 * breeding probability of SB31 * breeding success of SB31



% Transit to failed breeder, SB to FB
A(43,17) = theta(17)*theta(158)*(1-theta(299)); % survival of SB7 * breeding probability of SB7 * 1- breeding success of SB7
A(44,18) = theta(18)*theta(159)*(1-theta(300)); % survival of SB8 * breeding probability of SB8 * 1- breeding success of SB8
A(45,19) = theta(19)*theta(160)*(1-theta(301)); % survival of SB9 * breeding probability of SB9 * 1- breeding success of SB9
A(46,20) = theta(20)*theta(161)*(1-theta(302)); % survival of SB10 * breeding probability of SB10 * 1- breeding success of SB10
A(47,21) = theta(21)*theta(162)*(1-theta(303)); % survival of SB11 * breeding probability of SB11 * 1- breeding success of SB11
A(48,22) = theta(22)*theta(163)*(1-theta(304)); % survival of SB12 * breeding probability of SB12 * 1- breeding success of SB12
A(49,23) = theta(23)*theta(164)*(1-theta(305)); % survival of SB13 * breeding probability of SB13 * 1- breeding success of SB13
A(50,24) = theta(24)*theta(165)*(1-theta(306)); % survival of SB14 * breeding probability of SB14 * 1- breeding success of SB14
A(51,25) = theta(25)*theta(166)*(1-theta(307)); % survival of SB15 * breeding probability of SB15 * 1- breeding success of SB15
A(52,26) = theta(26)*theta(167)*(1-theta(308)); % survival of SB16 * breeding probability of SB16 * 1- breeding success of SB16
A(53,27) = theta(27)*theta(168)*(1-theta(309)); % survival of SB17 * breeding probability of SB17 * 1- breeding success of SB17
A(54,28) = theta(28)*theta(169)*(1-theta(310)); % survival of SB18 * breeding probability of SB18 * 1- breeding success of SB18
A(55,29) = theta(29)*theta(170)*(1-theta(311)); % survival of SB19 * breeding probability of SB19 * 1- breeding success of SB19
A(56,30) = theta(30)*theta(171)*(1-theta(312)); % survival of SB20 * breeding probability of SB20 * 1- breeding success of SB20
A(57,31) = theta(31)*theta(172)*(1-theta(313)); % survival of SB21 * breeding probability of SB21 * 1- breeding success of SB21
A(58,32) = theta(32)*theta(173)*(1-theta(314)); % survival of SB22 * breeding probability of SB22 * 1- breeding success of SB22
A(59,33) = theta(33)*theta(174)*(1-theta(315)); % survival of SB23 * breeding probability of SB23 * 1- breeding success of SB23
A(60,34) = theta(34)*theta(175)*(1-theta(316)); % survival of SB24 * breeding probability of SB24 * 1- breeding success of SB24
A(61,35) = theta(35)*theta(176)*(1-theta(317)); % survival of SB25 * breeding probability of SB25 * 1- breeding success of SB25
A(62,36) = theta(36)*theta(177)*(1-theta(318)); % survival of SB26 * breeding probability of SB26 * 1- breeding success of SB26
A(63,37) = theta(37)*theta(178)*(1-theta(319)); % survival of SB27 * breeding probability of SB27 * 1- breeding success of SB27
A(64,38) = theta(38)*theta(179)*(1-theta(320)); % survival of SB28 * breeding probability of SB28 * 1- breeding success of SB28
A(65,39) = theta(39)*theta(180)*(1-theta(321)); % survival of SB29 * breeding probability of SB29 * 1- breeding success of SB29
A(66,40) = theta(40)*theta(181)*(1-theta(322)); % survival of SB30 * breeding probability of SB30 * 1- breeding success of SB30
A(66,41) = theta(41)*theta(182)*(1-theta(323)); % survival of SB31 * breeding probability of SB31 * 1- breeding success of SB31


% Transit to post-successful breeder, SB to PSB
A(68,17) = theta(17)*(1-theta(158)); % survival of SB7 * 1- breeding probability of SB7
A(69,18) = theta(18)*(1-theta(159)); % survival of SB8 * 1- breeding probability of SB8
A(70,19) = theta(19)*(1-theta(160)); % survival of SB9 * 1- breeding probability of SB9 
A(71,20) = theta(20)*(1-theta(161)); % survival of SB10 * 1- breeding probability of SB10
A(72,21) = theta(21)*(1-theta(162)); % survival of SB11 * 1- breeding probability of SB11 
A(73,22) = theta(22)*(1-theta(163)); % survival of SB12 * 1- breeding probability of SB12 
A(74,23) = theta(23)*(1-theta(164)); % survival of SB13 * 1- breeding probability of SB13 
A(75,24) = theta(24)*(1-theta(165)); % survival of SB14 * 1- breeding probability of SB14
A(76,25) = theta(25)*(1-theta(166)); % survival of SB15 * 1- breeding probability of SB15 
A(77,26) = theta(26)*(1-theta(167)); % survival of SB16 * 1- breeding probability of SB16 
A(78,27) = theta(27)*(1-theta(168)); % survival of SB17 * 1- breeding probability of SB17 
A(79,28) = theta(28)*(1-theta(169)); % survival of SB18 * 1- breeding probability of SB18 
A(80,29) = theta(29)*(1-theta(170)); % survival of SB19 * 1- breeding probability of SB19 
A(81,30) = theta(30)*(1-theta(171)); % survival of SB20 * 1- breeding probability of SB20
A(82,31) = theta(31)*(1-theta(172)); % survival of SB21 * 1- breeding probability of SB21 
A(83,32) = theta(32)*(1-theta(173)); % survival of SB22 * 1- breeding probability of SB22
A(84,33) = theta(33)*(1-theta(174)); % survival of SB23 * 1- breeding probability of SB23
A(85,34) = theta(34)*(1-theta(175)); % survival of SB24 * 1- breeding probability of SB24
A(86,35) = theta(35)*(1-theta(176)); % survival of SB25 * 1- breeding probability of SB25
A(87,36) = theta(36)*(1-theta(177)); % survival of SB26 * 1- breeding probability of SB26 
A(88,37) = theta(37)*(1-theta(178)); % survival of SB27 * 1- breeding probability of SB27
A(89,38) = theta(38)*(1-theta(179)); % survival of SB28 * 1- breeding probability of SB28 
A(90,39) = theta(39)*(1-theta(180)); % survival of SB29 * 1- breeding probability of SB29 
A(91,40) = theta(40)*(1-theta(181)); % survival of SB30 * 1- breeding probability of SB30 
A(91,41) = theta(41)*(1-theta(182)); % survival of SB31 * 1- breeding probability of SB31 



%% Failed breeders, FB, transitions
% Remaining failed breeder, FB to FB
A(43,42) = theta(42)*theta(183)*(1-theta(324)); % survival of FB7 * breeding probability of FB7 * 1- breeding success of FB7
A(44,43) = theta(43)*theta(184)*(1-theta(325));
A(45,44) = theta(44)*theta(185)*(1-theta(326));
A(46,45) = theta(45)*theta(186)*(1-theta(327));
A(47,46) = theta(46)*theta(187)*(1-theta(328));
A(48,47) = theta(47)*theta(188)*(1-theta(329));
A(49,48) = theta(48)*theta(189)*(1-theta(330));
A(50,49) = theta(49)*theta(190)*(1-theta(331));
A(51,50) = theta(50)*theta(191)*(1-theta(332));
A(52,51) = theta(51)*theta(192)*(1-theta(333));
A(53,52) = theta(52)*theta(193)*(1-theta(334));
A(54,53) = theta(53)*theta(194)*(1-theta(335));
A(55,54) = theta(54)*theta(195)*(1-theta(336));
A(56,55) = theta(55)*theta(196)*(1-theta(337));
A(57,56) = theta(56)*theta(197)*(1-theta(338));
A(58,57) = theta(57)*theta(198)*(1-theta(339));
A(59,58) = theta(58)*theta(199)*(1-theta(340));
A(60,59) = theta(59)*theta(200)*(1-theta(341));
A(61,60) = theta(60)*theta(201)*(1-theta(342));
A(62,61) = theta(61)*theta(202)*(1-theta(343));
A(63,62) = theta(62)*theta(203)*(1-theta(344));
A(64,63) = theta(63)*theta(204)*(1-theta(345));
A(65,64) = theta(64)*theta(205)*(1-theta(346));
A(66,65) = theta(65)*theta(206)*(1-theta(347));
A(66,66) = theta(66)*theta(207)*(1-theta(348));


% Transit to successful breeder, FB to SB
A(18,42) = theta(42)*theta(183)*theta(324); % survival of FB7 * breeding probability of FB7 * breeding success of FB7
A(19,43) = theta(43)*theta(184)*theta(325);
A(20,44) = theta(44)*theta(185)*theta(326);
A(21,45) = theta(45)*theta(186)*theta(327);
A(22,46) = theta(46)*theta(187)*theta(328);
A(23,47) = theta(47)*theta(188)*theta(329);
A(24,48) = theta(48)*theta(189)*theta(330);
A(25,49) = theta(49)*theta(190)*theta(331);
A(26,50) = theta(50)*theta(191)*theta(332);
A(27,51) = theta(51)*theta(192)*theta(333);
A(28,52) = theta(52)*theta(193)*theta(334);
A(29,53) = theta(53)*theta(194)*theta(335);
A(30,54) = theta(54)*theta(195)*theta(336);
A(31,55) = theta(55)*theta(196)*theta(337);
A(32,56) = theta(56)*theta(197)*theta(338);
A(33,57) = theta(57)*theta(198)*theta(339);
A(34,58) = theta(58)*theta(199)*theta(340);
A(35,59) = theta(59)*theta(200)*theta(341);
A(36,60) = theta(60)*theta(201)*theta(342);
A(37,61) = theta(61)*theta(202)*theta(343);
A(38,62) = theta(62)*theta(203)*theta(344);
A(39,63) = theta(63)*theta(204)*theta(345);
A(40,64) = theta(64)*theta(205)*theta(346);
A(41,65) = theta(65)*theta(206)*theta(347);
A(41,66) = theta(66)*theta(207)*theta(348);

% Transit to post-failed breeder, FB to PFB
A(93,42) = theta(42)*(1-theta(183)); % survival of FB7 * 1 - breeding probability of FB7
A(94,43) = theta(43)*(1-theta(184));
A(95,44) = theta(44)*(1-theta(185));
A(96,45) = theta(45)*(1-theta(186));
A(97,46) = theta(46)*(1-theta(187));
A(98,47) = theta(47)*(1-theta(188));
A(99,48) = theta(48)*(1-theta(189));
A(100,49) = theta(49)*(1-theta(190));
A(101,50) = theta(50)*(1-theta(191));
A(102,51) = theta(51)*(1-theta(192));
A(103,52) = theta(52)*(1-theta(193));
A(104,53) = theta(53)*(1-theta(194));
A(105,54) = theta(54)*(1-theta(195));
A(106,55) = theta(55)*(1-theta(196));
A(107,56) = theta(56)*(1-theta(197));
A(108,57) = theta(57)*(1-theta(198));
A(109,58) = theta(58)*(1-theta(199));
A(110,59) = theta(59)*(1-theta(200));
A(111,60) = theta(60)*(1-theta(201));
A(112,61) = theta(61)*(1-theta(202));
A(113,62) = theta(62)*(1-theta(203));
A(114,63) = theta(63)*(1-theta(204));
A(115,64) = theta(64)*(1-theta(205));
A(116,65) = theta(65)*(1-theta(206));
A(116,66) = theta(66)*(1-theta(207));



%% Post-successful breeders, PSB, transitions
% Transit to successful breeder, PSB to SB
%A(18,67) = theta(67)*theta(208)*theta(349); note that this one will be zero as those transitions can only occur upon age 7
A(19,68) = theta(68)*theta(209)*theta(350); % survival of PSB8 * breeding probability of PSB8 * breeding success of PSB8; 
A(20,69) = theta(69)*theta(210)*theta(351); 
A(21,70) = theta(70)*theta(211)*theta(352); 
A(22,71) = theta(71)*theta(212)*theta(353); 
A(23,72) = theta(72)*theta(213)*theta(354); 
A(24,73) = theta(73)*theta(214)*theta(355); 
A(25,74) = theta(74)*theta(215)*theta(356); 
A(26,75) = theta(75)*theta(216)*theta(357); 
A(27,76) = theta(76)*theta(217)*theta(358); 
A(28,77) = theta(77)*theta(218)*theta(359); 
A(29,78) = theta(78)*theta(219)*theta(360); 
A(30,79) = theta(79)*theta(220)*theta(361); 
A(31,80) = theta(80)*theta(221)*theta(362); 
A(32,81) = theta(81)*theta(222)*theta(363); 
A(33,82) = theta(82)*theta(223)*theta(364); 
A(34,83) = theta(83)*theta(224)*theta(365); 
A(35,84) = theta(84)*theta(225)*theta(366); 
A(36,85) = theta(85)*theta(226)*theta(367); 
A(37,86) = theta(86)*theta(227)*theta(368); 
A(38,87) = theta(87)*theta(228)*theta(369); 
A(39,88) = theta(88)*theta(229)*theta(370); 
A(40,89) = theta(89)*theta(230)*theta(371); 
A(41,90) = theta(90)*theta(231)*theta(372); 
A(41,91) = theta(91)*theta(232)*theta(373); 


% Transit to failed breeder, PSB to FB
%A(43,67) = theta(67)*theta(208)*(1-theta(349));  note that this one will be zero as those transitions can only occur upon age 7
A(44,68) = theta(68)*theta(209)*(1-theta(350)); % survival of PSB8 * breeding probability of PSB8 * 1- breeding success of PSB8;
A(45,69) = theta(69)*theta(210)*(1-theta(351)); 
A(46,70) = theta(70)*theta(211)*(1-theta(352)); 
A(47,71) = theta(71)*theta(212)*(1-theta(353)); 
A(48,72) = theta(72)*theta(213)*(1-theta(354)); 
A(49,73) = theta(73)*theta(214)*(1-theta(355)); 
A(50,74) = theta(74)*theta(215)*(1-theta(356)); 
A(51,75) = theta(75)*theta(216)*(1-theta(357)); 
A(52,76) = theta(76)*theta(217)*(1-theta(358)); 
A(53,77) = theta(77)*theta(218)*(1-theta(359)); 
A(54,78) = theta(78)*theta(219)*(1-theta(360)); 
A(55,79) = theta(79)*theta(220)*(1-theta(361)); 
A(56,80) = theta(80)*theta(221)*(1-theta(362)); 
A(57,81) = theta(81)*theta(222)*(1-theta(363)); 
A(58,82) = theta(82)*theta(223)*(1-theta(364)); 
A(59,83) = theta(83)*theta(224)*(1-theta(365)); 
A(60,84) = theta(84)*theta(225)*(1-theta(366)); 
A(61,85) = theta(85)*theta(226)*(1-theta(367)); 
A(62,86) = theta(86)*theta(227)*(1-theta(368)); 
A(63,87) = theta(87)*theta(228)*(1-theta(369)); 
A(64,88) = theta(88)*theta(229)*(1-theta(370)); 
A(65,89) = theta(89)*theta(230)*(1-theta(371)); 
A(66,90) = theta(90)*theta(231)*(1-theta(372)); 
A(66,91) = theta(91)*theta(232)*(1-theta(373)); 

% Transit to non-breeder, PSB to NB
%A(118,67) = theta(67)*(1-theta(208));  note that this one will be zero as those transitions can only occur upon age 7
A(119,68) = theta(68)*(1-theta(209)); % survival of PSB8 * 1 - breeding probability of PSB8;
A(120,69) = theta(69)*(1-theta(210)); 
A(121,70) = theta(70)*(1-theta(211)); 
A(122,71) = theta(71)*(1-theta(212)); 
A(123,72) = theta(72)*(1-theta(213)); 
A(124,73) = theta(73)*(1-theta(214)); 
A(125,74) = theta(74)*(1-theta(215)); 
A(126,75) = theta(75)*(1-theta(216)); 
A(127,76) = theta(76)*(1-theta(217)); 
A(128,77) = theta(77)*(1-theta(218)); 
A(129,78) = theta(78)*(1-theta(219)); 
A(130,79) = theta(79)*(1-theta(220)); 
A(131,80) = theta(80)*(1-theta(221)); 
A(132,81) = theta(81)*(1-theta(222)); 
A(133,82) = theta(82)*(1-theta(223)); 
A(134,83) = theta(83)*(1-theta(224)); 
A(135,84) = theta(84)*(1-theta(225)); 
A(136,85) = theta(85)*(1-theta(226)); 
A(137,86) = theta(86)*(1-theta(227)); 
A(138,87) = theta(87)*(1-theta(228)); 
A(139,88) = theta(88)*(1-theta(229)); 
A(140,89) = theta(89)*(1-theta(230)); 
A(141,90) = theta(90)*(1-theta(231)); 
A(141,91) = theta(91)*(1-theta(232)); 

%% Post-failed breeders, PFB, transitions
% Transit to successful breeder, PFB to SB
%A(18,92) = theta(92)*theta(233)*theta(374); note that this is an impossible combinaison
A(19,93) = theta(93)*theta(234)*theta(375); % survival of PFB8 * breeding probability of PF8 * breeding success of PFB8
A(20,94) = theta(94)*theta(235)*theta(376);
A(21,95) = theta(95)*theta(236)*theta(377);
A(22,96) = theta(96)*theta(237)*theta(378);
A(23,97) = theta(97)*theta(238)*theta(379);
A(24,98) = theta(98)*theta(239)*theta(380);
A(25,99) = theta(99)*theta(240)*theta(381);
A(26,100) = theta(100)*theta(241)*theta(382);
A(27,101) = theta(101)*theta(242)*theta(383);
A(28,102) = theta(102)*theta(243)*theta(384);
A(29,103) = theta(103)*theta(244)*theta(385);
A(30,104) = theta(104)*theta(245)*theta(386);
A(31,105) = theta(105)*theta(246)*theta(387);
A(32,106) = theta(106)*theta(247)*theta(388);
A(33,107) = theta(107)*theta(248)*theta(389);
A(34,108) = theta(108)*theta(249)*theta(390);
A(35,109) = theta(109)*theta(250)*theta(391);
A(36,110) = theta(110)*theta(251)*theta(392);
A(37,111) = theta(111)*theta(252)*theta(393);
A(38,112) = theta(112)*theta(253)*theta(394);
A(39,113) = theta(113)*theta(254)*theta(395);
A(40,114) = theta(114)*theta(255)*theta(396);
A(41,115) = theta(115)*theta(256)*theta(397);
A(41,116) = theta(116)*theta(257)*theta(398);

% Transit to failed breeder, PFB to FB
%A(44,95) = theta(95)*theta(241)*(1-theta(387)); note that this is an impossible combinaison
A(44,93) = theta(93)*theta(234)*(1-theta(375)); % survival of PFB8 * breeding probability of PF8 * 1- breeding success of PFB8
A(45,94) = theta(94)*theta(235)*(1-theta(376));
A(46,95) = theta(95)*theta(236)*(1-theta(377));
A(47,96) = theta(96)*theta(237)*(1-theta(378));
A(48,97) = theta(97)*theta(238)*(1-theta(379));
A(49,98) = theta(98)*theta(239)*(1-theta(380));
A(50,99) = theta(99)*theta(240)*(1-theta(381));
A(51,100) = theta(100)*theta(241)*(1-theta(382));
A(52,101) = theta(101)*theta(242)*(1-theta(383));
A(53,102) = theta(102)*theta(243)*(1-theta(384));
A(54,103) = theta(103)*theta(244)*(1-theta(385));
A(55,104) = theta(104)*theta(245)*(1-theta(386));
A(56,105) = theta(105)*theta(246)*(1-theta(387));
A(57,106) = theta(106)*theta(247)*(1-theta(388));
A(58,107) = theta(107)*theta(248)*(1-theta(389));
A(59,108) = theta(108)*theta(249)*(1-theta(390));
A(60,109) = theta(109)*theta(250)*(1-theta(391));
A(61,110) = theta(110)*theta(251)*(1-theta(392));
A(62,111) = theta(111)*theta(252)*(1-theta(393));
A(63,112) = theta(112)*theta(253)*(1-theta(394));
A(64,113) = theta(113)*theta(254)*(1-theta(395));
A(65,114) = theta(114)*theta(255)*(1-theta(396));
A(66,115) = theta(115)*theta(256)*(1-theta(397));
A(66,116) = theta(116)*theta(257)*(1-theta(398));


% Transit to non-breeder, PFB to NB
%A(118,92) = theta(92)*(1-theta(233)); note that this is an impossible combinaison
A(119,93) = theta(93)*(1-theta(234)); % survival of PFB8 * 1- breeding probability of PF8
A(120,94) = theta(94)*(1-theta(235));
A(121,95) = theta(95)*(1-theta(236));
A(122,96) = theta(96)*(1-theta(237));
A(123,97) = theta(97)*(1-theta(238));
A(124,98) = theta(98)*(1-theta(239));
A(125,99) = theta(99)*(1-theta(240));
A(126,100) = theta(100)*(1-theta(241));
A(127,101) = theta(101)*(1-theta(242));
A(128,102) = theta(102)*(1-theta(243));
A(129,103) = theta(103)*(1-theta(244));
A(130,104) = theta(104)*(1-theta(245));
A(131,105) = theta(105)*(1-theta(246));
A(132,106) = theta(106)*(1-theta(247));
A(133,107) = theta(107)*(1-theta(248));
A(134,108) = theta(108)*(1-theta(249));
A(135,109) = theta(109)*(1-theta(250));
A(136,110) = theta(110)*(1-theta(251));
A(137,111) = theta(111)*(1-theta(252));
A(138,112) = theta(112)*(1-theta(253));
A(139,113) = theta(113)*(1-theta(254));
A(140,114) = theta(114)*(1-theta(255));
A(141,115) = theta(115)*(1-theta(256));
A(141,116) = theta(116)*(1-theta(257));




%% Non-breeders, NB, transitions
% Transit to successful breeder, NB to SB
%A(18,117) = theta(117)*theta(258)*theta(399); note that this is an impossible combinaison
%A(19,118) = theta(118)*theta(259)*theta(400); note that this is an impossible combinaison
A(20,119) = theta(119)*theta(260)*theta(401); % survival of NB9 * breeding probability of NB9* breeding success of NB9
A(21,120) = theta(120)*theta(261)*theta(402);
A(22,121) = theta(121)*theta(262)*theta(403);
A(23,122) = theta(122)*theta(263)*theta(404);
A(24,123) = theta(123)*theta(264)*theta(405);
A(25,124) = theta(124)*theta(265)*theta(406);
A(26,125) = theta(125)*theta(266)*theta(407);
A(27,126) = theta(126)*theta(267)*theta(408);
A(28,127) = theta(127)*theta(268)*theta(409);
A(29,128) = theta(128)*theta(269)*theta(410);
A(30,129) = theta(129)*theta(270)*theta(411);
A(31,130) = theta(130)*theta(271)*theta(412);
A(32,131) = theta(131)*theta(272)*theta(413);
A(33,132) = theta(132)*theta(273)*theta(414);
A(34,133) = theta(133)*theta(274)*theta(415);
A(35,134) = theta(134)*theta(275)*theta(416);
A(36,135) = theta(135)*theta(276)*theta(417);
A(37,136) = theta(136)*theta(277)*theta(418);
A(38,137) = theta(137)*theta(278)*theta(419);
A(39,138) = theta(138)*theta(279)*theta(420);
A(40,139) = theta(139)*theta(280)*theta(421);
A(41,140) = theta(140)*theta(281)*theta(422);
A(41,141) = theta(141)*theta(282)*theta(423);


% Transit to failed breeder, NB to FB
%A(43,117) = theta(117)*theta(258)*(1-theta(399)); %note that this is an impossible combinaison
%A(44,118) = theta(118)*theta(259)*(1-theta(400)); %note that this is an impossible combinaison
A(45,119) = theta(119)*theta(260)*(1-theta(401)); % survival of NB9 * breeding probability of NB9 * 1- breeding success of NB9
A(46,120) = theta(120)*theta(261)*(1-theta(402));
A(47,121) = theta(121)*theta(262)*(1-theta(403));
A(48,122) = theta(122)*theta(263)*(1-theta(404));
A(49,123) = theta(123)*theta(264)*(1-theta(405));
A(50,124) = theta(124)*theta(265)*(1-theta(406));
A(51,125) = theta(125)*theta(266)*(1-theta(407));
A(52,126) = theta(126)*theta(267)*(1-theta(408));
A(53,127) = theta(127)*theta(268)*(1-theta(409));
A(54,128) = theta(128)*theta(269)*(1-theta(410));
A(55,129) = theta(129)*theta(270)*(1-theta(411));
A(56,130) = theta(130)*theta(271)*(1-theta(412));
A(57,131) = theta(131)*theta(272)*(1-theta(413));
A(58,132) = theta(132)*theta(273)*(1-theta(414));
A(59,133) = theta(133)*theta(274)*(1-theta(415));
A(60,134) = theta(134)*theta(275)*(1-theta(416));
A(61,135) = theta(135)*theta(276)*(1-theta(417));
A(62,136) = theta(136)*theta(277)*(1-theta(418));
A(63,137) = theta(137)*theta(278)*(1-theta(419));
A(64,138) = theta(138)*theta(279)*(1-theta(420));
A(65,139) = theta(139)*theta(280)*(1-theta(421));
A(66,140) = theta(140)*theta(281)*(1-theta(422));
A(66,141) = theta(141)*theta(282)*(1-theta(423));


% Remain a non-breeder, NB to NB
%A(118,117) = theta(117)*(1-theta(258)); %note that this is an impossible combinaison
%A(119,118) = theta(118)*(1-theta(259)); %note that this is an impossible combinaison
A(120,119) = theta(119)*(1-theta(260)); % survival of NB9 * 1- breeding probability of NB9
A(121,120) = theta(120)*(1-theta(261));
A(122,121) = theta(121)*(1-theta(262));
A(123,122) = theta(122)*(1-theta(263));
A(124,123) = theta(123)*(1-theta(264));
A(125,124) = theta(124)*(1-theta(265));
A(126,125) = theta(125)*(1-theta(266));
A(127,126) = theta(126)*(1-theta(267));
A(128,127) = theta(127)*(1-theta(268));
A(129,128) = theta(128)*(1-theta(269));
A(130,129) = theta(129)*(1-theta(270));
A(131,130) = theta(130)*(1-theta(271));
A(132,131) = theta(131)*(1-theta(272));
A(133,132) = theta(132)*(1-theta(273));
A(134,133) = theta(133)*(1-theta(274));
A(135,134) = theta(134)*(1-theta(275));
A(136,135) = theta(135)*(1-theta(276));
A(137,136) = theta(136)*(1-theta(277));
A(138,137) = theta(137)*(1-theta(278));
A(139,138) = theta(138)*(1-theta(279));
A(140,139) = theta(139)*(1-theta(280));
A(141,140) = theta(140)*(1-theta(281));
A(141,141) = theta(141)*(1-theta(282));



U = A;

%% Fertilities
% from pre-breeders
A(1,6) = theta(6)*theta(147)*theta(288)*rho; 
A(1,7) = theta(7)*theta(148)*theta(289)*rho; 
A(1,8) = theta(8)*theta(149)*theta(290)*rho; 
A(1,9) = theta(9)*theta(150)*theta(291)*rho; 
A(1,10) = theta(10)*theta(151)*theta(292)*rho; 
A(1,11) = theta(11)*theta(152)*theta(293)*rho; 
A(1,12) = theta(12)*theta(153)*theta(294)*rho;
A(1,13) = theta(13)*theta(154)*theta(295)*rho; 
A(1,14) = theta(14)*theta(155)*theta(296)*rho; 
A(1,15) = theta(15)*theta(156)*theta(297)*rho; 
A(1,16) = theta(16)*theta(157)*theta(298)*rho; 

% From successful breeders
A(1,17) = theta(17)*theta(158)*theta(299)*rho; 
A(1,18) = theta(18)*theta(159)*theta(300)*rho; 
A(1,19) = theta(19)*theta(160)*theta(301)*rho; 
A(1,20) = theta(20)*theta(161)*theta(302)*rho; 
A(1,21) = theta(21)*theta(162)*theta(303)*rho; 
A(1,22) = theta(22)*theta(163)*theta(304)*rho; 
A(1,23) = theta(23)*theta(164)*theta(305)*rho;
A(1,24) = theta(24)*theta(165)*theta(306)*rho; 
A(1,25) = theta(25)*theta(166)*theta(307)*rho; 
A(1,26) = theta(26)*theta(167)*theta(308)*rho; 
A(1,27) = theta(27)*theta(168)*theta(309)*rho; 
A(1,28) = theta(28)*theta(169)*theta(310)*rho; 
A(1,29) = theta(29)*theta(170)*theta(311)*rho; 
A(1,30) = theta(30)*theta(171)*theta(312)*rho; 
A(1,31) = theta(31)*theta(172)*theta(313)*rho; 
A(1,32) = theta(32)*theta(173)*theta(314)*rho; 
A(1,33) = theta(33)*theta(174)*theta(315)*rho; 
A(1,34) = theta(34)*theta(175)*theta(316)*rho; 
A(1,35) = theta(35)*theta(176)*theta(317)*rho; 
A(1,36) = theta(36)*theta(177)*theta(318)*rho; 
A(1,37) = theta(37)*theta(178)*theta(319)*rho; 
A(1,38) = theta(38)*theta(179)*theta(320)*rho; 
A(1,39) = theta(39)*theta(180)*theta(321)*rho; 
A(1,40) = theta(40)*theta(181)*theta(322)*rho;
A(1,41) = theta(41)*theta(182)*theta(323)*rho; 

% From failed breeders
A(1,42) = theta(42)*theta(183)*theta(324)*rho; 
A(1,43) = theta(43)*theta(184)*theta(325)*rho; 
A(1,44) = theta(44)*theta(185)*theta(326)*rho;
A(1,45) = theta(45)*theta(186)*theta(327)*rho;
A(1,46) = theta(46)*theta(187)*theta(328)*rho;
A(1,47) = theta(47)*theta(188)*theta(329)*rho;
A(1,48) = theta(48)*theta(189)*theta(330)*rho;
A(1,49) = theta(49)*theta(190)*theta(331)*rho;
A(1,50) = theta(50)*theta(191)*theta(332)*rho;
A(1,51) = theta(51)*theta(192)*theta(333)*rho;
A(1,52) = theta(52)*theta(193)*theta(334)*rho;
A(1,53) = theta(53)*theta(194)*theta(335)*rho;
A(1,54) = theta(54)*theta(195)*theta(336)*rho;
A(1,55) = theta(55)*theta(196)*theta(337)*rho;
A(1,56) = theta(56)*theta(197)*theta(338)*rho;
A(1,57) = theta(57)*theta(198)*theta(339)*rho;
A(1,58) = theta(58)*theta(199)*theta(340)*rho;
A(1,59) = theta(59)*theta(200)*theta(341)*rho;
A(1,60) = theta(60)*theta(201)*theta(342)*rho;
A(1,61) = theta(61)*theta(202)*theta(343)*rho;
A(1,62) = theta(62)*theta(203)*theta(344)*rho;
A(1,63) = theta(63)*theta(204)*theta(345)*rho;
A(1,64) = theta(64)*theta(205)*theta(346)*rho;
A(1,65) = theta(65)*theta(206)*theta(347)*rho;
A(1,66) = theta(66)*theta(207)*theta(348)*rho;


% From Post-successful breeders
%A(1,67) = theta(67)*theta(208)*theta(349)*rho;
A(1,68) = theta(68)*theta(209)*theta(350)*rho;
A(1,69) = theta(69)*theta(210)*theta(351)*rho;
A(1,70) = theta(70)*theta(211)*theta(352)*rho; 
A(1,71) = theta(71)*theta(212)*theta(353)*rho; 
A(1,72) = theta(72)*theta(213)*theta(354)*rho; 
A(1,73) = theta(73)*theta(214)*theta(355)*rho; 
A(1,74) = theta(74)*theta(215)*theta(356)*rho; 
A(1,75) = theta(75)*theta(216)*theta(357)*rho; 
A(1,76) = theta(76)*theta(217)*theta(358)*rho; 
A(1,77) = theta(77)*theta(218)*theta(359)*rho; 
A(1,78) = theta(78)*theta(219)*theta(360)*rho; 
A(1,79) = theta(79)*theta(220)*theta(361)*rho; 
A(1,80) = theta(80)*theta(221)*theta(362)*rho; 
A(1,81) = theta(81)*theta(222)*theta(363)*rho; 
A(1,82) = theta(82)*theta(223)*theta(364)*rho; 
A(1,83) = theta(83)*theta(224)*theta(365)*rho; 
A(1,84) = theta(84)*theta(225)*theta(366)*rho; 
A(1,85) = theta(85)*theta(226)*theta(367)*rho; 
A(1,86) = theta(86)*theta(227)*theta(368)*rho; 
A(1,87) = theta(87)*theta(228)*theta(369)*rho; 
A(1,88) = theta(88)*theta(229)*theta(370)*rho; 
A(1,89) = theta(89)*theta(230)*theta(371)*rho; 
A(1,90) = theta(90)*theta(231)*theta(372)*rho; 
A(1,91) = theta(91)*theta(232)*theta(373)*rho; 


% From Post-failed breeders
%A(1,92) = theta(92)*theta(233)*theta(374)*rho; 
A(1,93) = theta(93)*theta(234)*theta(375)*rho; 
A(1,94) = theta(94)*theta(235)*theta(376)*rho; 
A(1,95) = theta(95)*theta(236)*theta(377)*rho; 
A(1,96) = theta(96)*theta(237)*theta(378)*rho;
A(1,97) = theta(97)*theta(238)*theta(379)*rho;
A(1,98) = theta(98)*theta(239)*theta(380)*rho;
A(1,99) = theta(99)*theta(240)*theta(381)*rho;
A(1,100) = theta(100)*theta(241)*theta(382)*rho;
A(1,101) = theta(101)*theta(242)*theta(383)*rho;
A(1,102) = theta(102)*theta(243)*theta(384)*rho;
A(1,103) = theta(103)*theta(244)*theta(385)*rho;
A(1,104) = theta(104)*theta(245)*theta(386)*rho;
A(1,105) = theta(105)*theta(246)*theta(387)*rho;
A(1,106) = theta(106)*theta(247)*theta(388)*rho;
A(1,107) = theta(107)*theta(248)*theta(389)*rho;
A(1,108) = theta(108)*theta(249)*theta(390)*rho;
A(1,109) = theta(109)*theta(250)*theta(391)*rho;
A(1,110) = theta(110)*theta(251)*theta(392)*rho;
A(1,111) = theta(111)*theta(252)*theta(393)*rho;
A(1,112) = theta(112)*theta(253)*theta(394)*rho;
A(1,113) = theta(113)*theta(254)*theta(395)*rho;
A(1,114) = theta(114)*theta(255)*theta(396)*rho;
A(1,115) = theta(115)*theta(256)*theta(397)*rho;
A(1,116) = theta(116)*theta(257)*theta(398)*rho;


% From non-breeders
%A(1,117) = theta(117)*theta(258)*theta(399)*rho;
%A(1,118) = theta(118)*theta(259)*theta(400)*rho;
A(1,119) = theta(119)*theta(260)*theta(401)*rho;
A(1,120) = theta(120)*theta(261)*theta(402)*rho;
A(1,121) = theta(121)*theta(262)*theta(403)*rho; 
A(1,122) = theta(122)*theta(263)*theta(404)*rho; 
A(1,123) = theta(123)*theta(264)*theta(405)*rho;
A(1,124) = theta(124)*theta(265)*theta(406)*rho;
A(1,125) = theta(125)*theta(266)*theta(407)*rho;
A(1,126) = theta(126)*theta(267)*theta(408)*rho;
A(1,127) = theta(127)*theta(268)*theta(409)*rho;
A(1,128) = theta(128)*theta(269)*theta(410)*rho;
A(1,129) = theta(129)*theta(270)*theta(411)*rho;
A(1,130) = theta(130)*theta(271)*theta(412)*rho;
A(1,131) = theta(131)*theta(272)*theta(413)*rho;
A(1,132) = theta(132)*theta(273)*theta(414)*rho;
A(1,133) = theta(133)*theta(274)*theta(415)*rho;
A(1,134) = theta(134)*theta(275)*theta(416)*rho;
A(1,135) = theta(135)*theta(276)*theta(417)*rho;
A(1,136) = theta(136)*theta(277)*theta(418)*rho;
A(1,137) = theta(137)*theta(278)*theta(419)*rho;
A(1,138) = theta(138)*theta(279)*theta(420)*rho;
A(1,139) = theta(139)*theta(280)*theta(421)*rho;
A(1,140) = theta(140)*theta(281)*theta(422)*rho;
A(1,141) = theta(141)*theta(282)*theta(423)*rho;


F(1,:)=A(1,:);

% transition matrix

out.A=A;
out.F=F;
out.U=U;
out.theta=theta;

return

