// This file is part of Playslave-C++.
// Playslave-C++ is licenced under the MIT license: see LICENSE.txt.

/**
 * @file
 * Implementation of the PosixIoReactor class.
 * @see io/io_reactor_posix.hpp
 * @see io/io_reactor.hpp
 * @see io/io_reactor.cpp
 * @see io/io_reactor_tcp.hpp
 * @see io/io_reactor_tcp.cpp
 * @see io/io_reactor_win.hpp
 * @see io/io_reactor_win.cpp
 */

#include <boost/asio.hpp>

#ifdef BOOST_ASIO_HAS_POSIX_STREAM_DESCRIPTOR

#include <iostream>             // std::cout
#include <ostream>              // std::ostream
#include <string>               // std::string
#include <unistd.h>             // STDIN_FILENO
#include "../cmd.hpp"           // CommandHandler
#include "../player/player.hpp" // Player
#include "io_reactor_posix.hpp" // PosixIoReactor

PosixIoReactor::PosixIoReactor(Player &player, CommandHandler &handler)
    : IoReactor(player, handler), input(io_service, ::dup(STDIN_FILENO))
{
	SetupWaitForInput();
}

void PosixIoReactor::RespondRaw(const std::string &string)
{
	// There's no need for this to be asynchronous, so we just use iostream.
	std::cout << string << std::flush;
}

void PosixIoReactor::SetupWaitForInput()
{
	boost::asio::async_read_until(
	                input, data, "\n",
	                [this](const boost::system::error_code &ec,
	                       std::size_t) {
		                if (!ec) {
			                std::istream is(&data);
			                std::string s;
			                std::getline(is, s);

			                HandleCommand(s);
			                SetupWaitForInput();
		                }
		        });
}

#endif // BOOST_ASIO_HAS_POSIX_STREAM_DESCRIPTOR