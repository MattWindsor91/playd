// This file is part of Playslave-C++.
// Playslave-C++ is licenced under the MIT license: see LICENSE.txt.

/**
 * @file
 * Declaration of the IoReactor abstract class.
 * @see io/io_reactor.cpp
 * @see io/io_reactor_asio.hpp
 * @see io/io_reactor_asio.cpp
 * @see io/io_reactor_std.hpp
 * @see io/io_reactor_std.cpp
 */

#ifndef PS_IO_REACTOR_HPP
#define PS_IO_REACTOR_HPP

#include "io_responder.hpp"

class Player;
class CommandHandler;

/**
 * The IO reactor, which services input, routes responses, and executes the
 * Player update routine periodically.
 */
class IoReactor : public Responder {
public:
	/**
	 * Constructs an IoReactor.
	 * @param player The player to which periodic update requests shall be
	 *   sent.
	 * @param handler The handler to which command inputs shall be sent.
	 */
	IoReactor(Player &player, CommandHandler &handler);

	/**
	 * Runs the reactor.
	 * It will block until terminated.
	 */
	void Run();

	/**
	 * Ends the reactor.
	 * This should be called by the parent object when the player is
	 * quitting.
	 */
	virtual void End() = 0;

protected:
	Player &player;          ///< The player.
	CommandHandler &handler; ///< The command handler.

	/**
	 * Sends a command to the command handler.
	 * The result of the command is responded on as per the playslave API.
	 * @param line The command line received by the IO reactor.
	 */
	void HandleCommand(const std::string &line);

	/**
	 * The reactor's main loop.
	 * It will block until a quit command is received.
	 * @return The exit code of the main loop.
	 */
	virtual void MainLoop() = 0;
};

#endif // PS_IO_REACTOR_HPP