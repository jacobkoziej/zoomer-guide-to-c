float Q_rsqrt( float number )
{
	long i;
	float x2, y;
	const float threehalfs = 1.5F;

	x2 = number * 0.5F;
	y  = number;
	i  = * ( long * ) &y;                       // evil floating point bit level hacking
	i  = 0x5f3759df - ( i >> 1 );               // what the fuck?
	y  = * ( float * ) &i;
	y  = y * ( threehalfs - ( x2 * y * y ) );   // 1st iteration
//	y  = y * ( threehalfs - ( x2 * y * y ) );   // 2nd iteration, this can be removed

#ifndef Q3_VM
#ifdef __linux__
	assert( !isnan(y) ); // bk010122 - FPE?
#endif
#endif
	return y;
}

// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Q_rsqrt.c -- fast inverse square root
 * Copyright (C) 1999--2005  Id Software, Inc.
 * <https://github.com/id-Software/Quake-III-Arena/blob/master/code/game/q_math.c#L552>
 */
