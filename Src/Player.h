#pragma once
#ifndef PLAYER_H
#define PLAYER_H

#include <godot_cpp/classes/node2d.hpp>

namespace godot {

	class Player : public Node2D {
		GDCLASS(Player, Node2D)
	private:
		int max_hp;
		int hp;
		int damage;

	protected:
		static void _bind_methods();

	public:
		Player();
		~Player();

		void set_max_hp(const int max_hp);
		int get_max_hp() const;

		void set_hp(const int hp);
		int get_hp() const;

		void set_damage(const int damage);
		int get_damage() const;

		void play(String word);
		void _process(double delta);
	};
}

#endif