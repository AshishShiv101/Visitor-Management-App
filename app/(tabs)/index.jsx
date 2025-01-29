import { View, Text, ScrollView, StyleSheet } from 'react-native';
import React from 'react';
import TopCard from '../../components/Home/TopCard';
import History from '../../components/Home/History';
import { Redirect } from 'expo-router';
import Colors from '../../constant/Colors';

export default function index() {
  return (
    <ScrollView>
      <View style={styles.header}>
        <View style={styles.avatarContainer}>
          <Text style={styles.avatarText}>RK</Text>
        </View>
        <Text style={styles.title}>Rishi Kapoor</Text>
      </View>
      <View style={styles.container}>
        <TopCard />
        <History />
        {/* <Redirect href={'login'}/> */}
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
    paddingTop: 20,
  },
  header: {
    backgroundColor: Colors.BUTTON,
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 20,
    height: 80,
    borderBottomLeftRadius: 20,
    borderBottomRightRadius: 20,
  },
  avatarContainer: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 1.5,
    borderColor: 'rgba(255, 255, 255, 0.5)',
    marginRight: 12,
  },
  avatarText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#FFFFFF',
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#fff',
    flex: 1,
    marginLeft:40
  },
});