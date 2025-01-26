import React from 'react';
import { Tabs } from 'expo-router';
import FontAwesome5 from '@expo/vector-icons/FontAwesome5';
import FontAwesome from '@expo/vector-icons/FontAwesome';
import Colors from '../../constant/Colors';

export default function _layout() {
  return (
    <Tabs
      screenOptions={{
        headerShown: false,
        tabBarStyle: {
          backgroundColor: Colors.FIELD, // Background color of the tab bar
          height: 75, // Adjusted height for a better look
          borderTopWidth: 0, // Removed top border
          elevation: 5, // Added shadow for better visual appeal
          borderTopLeftRadius: 20, // Rounded top left corner
          borderTopRightRadius: 20, // Rounded top right corner
          overflow: 'hidden', // Ensures the rounded corners are applied
        },
        tabBarActiveTintColor: Colors.BUTTON, // Color for selected icons
        tabBarInactiveTintColor: Colors.PRIMARY, // Color for unselected icons
        tabBarLabelStyle: {
          fontSize: 12, // Font size for labels
          fontWeight: '600', // Bold labels
          marginBottom: 5, // Spacing below the label
        },
        tabBarIconStyle: {
          marginTop:10, // Spacing above the icon
        },
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          tabBarLabel: 'Home',
          tabBarIcon: ({ color, size }) => (
            <FontAwesome5 name="home" size={20} color={color} />
          ),
        }}
      />
      <Tabs.Screen
        name="Profile"
        options={{
          tabBarLabel: 'Profile',
          tabBarIcon: ({ color, size }) => (
            <FontAwesome name="user" size={20} color={color} />
          ),
        }}
      />
    </Tabs>
  );
}
