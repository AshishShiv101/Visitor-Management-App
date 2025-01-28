import React from 'react';
import { Tabs } from 'expo-router';
import FontAwesome5 from '@expo/vector-icons/FontAwesome5';
import FontAwesome from '@expo/vector-icons/FontAwesome';
import { LinearGradient } from 'expo-linear-gradient';
import Colors from '../../constant/Colors';

export default function _layout() {
  return (
    <Tabs
      screenOptions={{
        headerShown: false,
        tabBarStyle: {
          backgroundColor: 'transparent', // Allow the gradient background to show through
          height: 80, // Slightly taller for a premium feel
          borderTopWidth: 0,
          elevation: 10, // Enhanced shadow for a floating effect
          borderTopLeftRadius: 20,
          borderTopRightRadius: 20,
          overflow: 'hidden',
          paddingBottom: 10, // Added padding for better spacing
        },
        tabBarActiveTintColor: '#FFFFFF', // White for selected icons for contrast
        tabBarInactiveTintColor: '#B0BEC5', // Muted gray for unselected icons
        tabBarLabelStyle: {
          fontSize: 13, // Slightly larger font for readability
          fontWeight: 'bold', // Bold labels for clarity
        },
        tabBarIconStyle: {
          marginTop: 5, // Reduced margin for better alignment
        },
        tabBarBackground: () => (
          <LinearGradient
            colors={['#3949AB', '#6A1B9A']} // Indigo to purple gradient for contrast
            style={{ flex: 1 }}
            start={{ x: 0, y: 0 }}
            end={{ x: 1, y: 0 }}
          />
        ),
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          tabBarLabel: 'Home',
          tabBarIcon: ({ color }) => (
            <FontAwesome5 name="home" size={24} color={color} />
          ),
        }}
      />
      <Tabs.Screen
        name="Profile"
        options={{
          tabBarLabel: 'Profile',
          tabBarIcon: ({ color }) => (
            <FontAwesome name="user" size={24} color={color} />
          ),
        }}
      />
    </Tabs>
  );
}
