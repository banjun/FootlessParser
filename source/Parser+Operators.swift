//
// Parser+Operators.swift
// FootlessParser
//
// Released under the MIT License (MIT), http://opensource.org/licenses/MIT
//
// Copyright (c) 2015 NotTooBad Software. All rights reserved.
//

import Result
import Runes

public func >>- <T,A,B> (p: Parser<T,A>, f: A -> Parser<T,B>) -> Parser<T,B> {
	return Parser { input in
		p.parse(input) >>- { f($0.output).parse($0.nextinput) }
	}
}

/**
	Wrap a value in a minimal context of Parser. Also known as 'return' in Haskell.

	:param: a A value of type A

	:returns: A parser which ignores the input and returns 'a'.
*/
public func pure <A> (a: A) -> Parser<A,A> {
	return Parser { input in .success(output:a, nextinput: input) }
}
