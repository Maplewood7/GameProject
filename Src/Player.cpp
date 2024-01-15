#include "Player.h"
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/godot.hpp>
#include <godot_cpp/variant/utility_functions.hpp>
#include <godot_cpp/classes/engine.hpp>
#include <godot_cpp/classes/input.hpp>
#include <godot_cpp/classes/label_settings.hpp>

using namespace godot;

void Player::_bind_methods() 
{
	ClassDB::bind_method(D_METHOD("get_max_hp"), &Player::get_max_hp);
	ClassDB::bind_method(D_METHOD("set_max_hp", "max_hp"), &Player::set_max_hp);

	ClassDB::add_property("Player", PropertyInfo(Variant::INT, "max_hp"), "set_max_hp", "get_max_hp");

	ClassDB::bind_method(D_METHOD("get_hp"), &Player::get_hp);
	ClassDB::bind_method(D_METHOD("set_hp", "hp"), &Player::set_hp);

	ClassDB::add_property("Player", PropertyInfo(Variant::INT, "hp"), "set_hp", "get_hp");

	ClassDB::bind_method(D_METHOD("get_damage"), &Player::get_damage);
	ClassDB::bind_method(D_METHOD("set_damage", "damage"), &Player::set_damage);

	ClassDB::add_property("Player", PropertyInfo(Variant::INT, "damage"), "set_damage", "get_damage");
}

Player::Player() 
{
	if (Engine::get_singleton()->is_editor_hint())
	{
		set_process_mode(Node::ProcessMode::PROCESS_MODE_DISABLED);
	}
}

Player::~Player() 
{

}

void Player::play(String word) 
{

}

void Player::_process(double delta)
{

}

void Player::set_max_hp(const int max_hp)
{
	this->max_hp = max_hp;
}
int Player::get_max_hp() const
{
	return max_hp;
}

void Player::set_hp(const int hp)
{
	this->hp = hp;
}
int Player::get_hp() const
{
	return hp;
}

void Player::set_damage(const int damage)
{
	this->damage = damage;
}
int Player::get_damage() const
{
	return damage;
}